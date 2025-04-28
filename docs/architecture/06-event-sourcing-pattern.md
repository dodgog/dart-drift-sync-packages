# Event Sourcing Pattern Implementation

This document details how the Event Sourcing pattern is implemented in the
dart-drift-sync-packages system, explaining the concepts, benefits, and specific
implementation details.

## Event Sourcing Concept

Event Sourcing is an architectural pattern where:

1. All changes to application state are stored as a sequence of events
2. Events are immutable facts that represent actions that have happened
3. The current state can be derived by replaying all events
4. The event log becomes the principal source of truth

This approach differs from traditional CRUD where only the current state is
stored.

## Benefits in the Context of This System

The dart-drift-sync-packages implementation leverages these benefits:

1. **Complete History** - Every change is preserved, enabling auditing and
   time-based analysis
2. **Natural Fit for Sync** - Events are easy to transfer between systems
3. **Conflict Resolution** - Timestamps provide natural ordering for conflict
   resolution
4. **State Reconstruction** - Any point-in-time state can be derived by
   replaying events
5. **Decoupled Logic** - Event processing is separated from event generation

## Event Structure

In this system, events are structured as:

```dart
// In events.drift
CREATE TABLE events (
    id TEXT NOT NULL PRIMARY KEY,
    client_id TEXT NOT NULL REFERENCES clients(id),
    entity_id TEXT NOT NULL,
    attribute TEXT NOT NULL,
    value TEXT NOT NULL,
    timestamp TEXT NOT NULL
);
```

Each event represents a change to a single attribute of an entity:

- `id` - Unique identifier for the event
- `client_id` - Identifies which client generated the event
- `entity_id` - Identifies the entity being modified
- `attribute` - The property of the entity being changed
- `value` - The new value for the attribute
- `timestamp` - When the change occurred (using HLC)

## Event Generation

Events are generated locally on a client when application state changes:

```dart
// Example event generation (pseudocode from understanding implementation)
Future<void> updateEntityAttribute(
    String entityId, String attribute, String value) async {
  final event = Event(
    id: generateUuidV7String(),
    clientId: currentClient.id,
    entityId: entityId,
    attribute: attribute,
    value: value,
    timestamp: HLC().sendPacked(),
  );
  
  // Store event in local database
  await insertLocalEvent(event);
  
  // Update materialized view in attributes table
  await insertLocalEventIntoAttributes(event);
}
```

## Event Processing

Events are processed to update the current state view (the attributes table):

```sql
-- From attributes.drift
insertEventIntoAttributes:
INSERT INTO attributes (entity_id, attribute, value, timestamp)
VALUES (
    :entity_id,
    :attribute,
    :value,
    :timestamp
)
ON CONFLICT (entity_id, attribute) DO UPDATE
SET value = excluded.value,
    timestamp = excluded.timestamp
WHERE excluded.timestamp > attributes.timestamp;
```

This SQL:

1. Inserts the event's data into the attributes table
2. If the attribute already exists, only updates if the new event is newer
3. Effectively implements a "last-write-wins" conflict resolution

## State Derivation

The current state is derived from events in two ways:

### 1. Incremental Updates

When a new event arrives, the system updates the materialized view directly:

```dart
Future<void> insertLocalEventIntoAttributes(Event event) async {
  await clientDrift.eventsDrift.insertEventIntoAttributes(
    entityId: event.entityId,
    attribute: event.attribute,
    value: event.value,
    timestamp: event.timestamp,
  );
}
```

### 2. Full Reconstruction

The system can also completely rebuild the current state from all events:

```sql
-- From attributes.drift
insertAllEventsIntoAttributes:
INSERT OR REPLACE INTO attributes (entity_id, attribute, value, timestamp)
SELECT e1.entity_id, e1.attribute, e1.value, e1.timestamp
FROM events e1
LEFT OUTER JOIN events e2 ON
  e1.entity_id = e2.entity_id AND
  e1.attribute = e2.attribute AND
  e2.timestamp > e1.timestamp
WHERE e2.entity_id IS NULL
AND NOT EXISTS (
  SELECT 1 FROM attributes a
  WHERE a.entity_id = e1.entity_id
  AND a.attribute = e1.attribute
  AND a.timestamp > e1.timestamp
);
```

This complex query:

1. Selects only the latest event for each entity/attribute pair
2. Ensures no newer event exists for that entity/attribute
3. Rebuilds the entire attributes table from the event history

## Event Bundling for Synchronization

For synchronization, events are grouped into bundles:

```dart
// Create a bundle from events
final bundle = Bundle(
  id: generateUuidV7String(),
  userId: config.userId!,
  timestamp: HLC().sendPacked(),
  payload: jsonEncode(EventPayload(events: events).toJson()),
);
```

Bundles provide:

- Batching for efficient network transfer
- Atomic transaction units
- Confirmation tracking

## Event Time Ordering with HLC

The system uses Hybrid Logical Clocks (HLC) to ensure proper event ordering:

```dart
// Initialize HLC for a client
HLC.initialize(clientNode: ClientNode(currentClient.id));

// Generate timestamp for a new event
final timestamp = HLC().sendPacked();

// Update HLC when receiving an event from another node
HLC().receivePacked(remoteTimestamp);
```

HLC combines physical time with logical counters to:

1. Ensure event causality is preserved
2. Handle clock skew between distributed devices
3. Allow for deterministic ordering of concurrent events

## Conflict Resolution

Conflict resolution is implemented via the timestamp comparison:

1. When two events modify the same entity/attribute
2. The event with the later timestamp wins
3. HLC timestamps ensure this preserves causality
4. This implements a "last-write-wins" policy

```sql
-- From attributes.drift, the conflict resolution logic
ON CONFLICT (entity_id, attribute) DO UPDATE
SET value = excluded.value,
    timestamp = excluded.timestamp
WHERE excluded.timestamp > attributes.timestamp;
```

## Snapshots and Performance Optimization

While the system does not yet implement full snapshotting, the attributes table
serves as a form of snapshot:

1. It represents the current state derived from all events
2. It allows for efficient queries without processing all events
3. It can be rebuilt from the event log if needed

Future optimizations could include:

- Periodic snapshots of the entire state
- Pruning of old events after snapshotting
- Selective event replay for specific entities

## Query APIs

The system provides query APIs that work with the derived state:

```dart
// Example query API (derived from repository understanding)
Future<List<EntityWithAttributes>> getEntitiesByType(String type) async {
  final results = await (select(attributesTable)
    ..where((t) => t.attribute.equals('type') & t.value.equals(type)))
    .get();
    
  // Get all attributes for the matching entities
  final List<EntityWithAttributes> entities = [];
  for (final result in results) {
    final allAttributes = await (select(attributesTable)
      ..where((t) => t.entityId.equals(result.entityId)))
      .get();
      
    // Convert to entity model
    entities.add(EntityWithAttributes.fromAttributes(allAttributes));
  }
  
  return entities;
}
```

## Event Sourcing Implementation Challenges

The implementation addresses several common challenges:

### 1. Schema Evolution

The system handles schema evolution by:

- Using text-based values for flexibility
- Maintaining schema version numbers
- Including migration strategies

### 2. Performance

Performance optimizations include:

- The attributes table as a materialized view
- Indexed queries on common attributes
- Batched event processing
- Incremental sync to reduce data transfer

### 3. Concurrency

Concurrency is managed through:

- HLC timestamps for ordering
- Last-write-wins conflict resolution
- Transaction-based updates

### 4. Query Complexity

The system simplifies queries by:

- Providing the attributes table for direct state access
- Offering helper methods for common queries
- Abstracting event processing details

## Future Enhancements

The event sourcing implementation could be enhanced with:

1. **Event Schemas** - More structured event payloads with validation
2. **Projections** - Specialized read models for specific query needs
3. **Event Versioning** - Support for evolving event schemas
4. **Event Handlers** - More sophisticated processing of events
5. **Command Pattern** - Adding a command layer that generates events
