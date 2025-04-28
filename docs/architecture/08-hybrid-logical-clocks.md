# Hybrid Logical Clocks

This document explains how Hybrid Logical Clocks (HLC) are used in the
dart-drift-sync-packages system for distributed time synchronization and event
ordering.

## The Problem of Time in Distributed Systems

In a distributed system like this client-server architecture, several challenges
arise around time:

1. **Clock Skew** - Different devices have different physical clocks, which may
   be out of sync
2. **Ordering Events** - Need to establish a consistent order for events from
   different sources
3. **Causality** - Need to ensure events that cause other events appear earlier
   in the timeline
4. **Partial Ordering** - Not all events have a direct causal relationship

Traditional approaches like using wall-clock time can lead to issues when clocks
are incorrect or when events happen in rapid succession.

## Hybrid Logical Clocks Overview

Hybrid Logical Clocks (HLC) combine the best aspects of:

1. **Physical Clocks** - Using actual time from device clocks
2. **Logical Clocks** - Using counters to establish ordering

HLC ensures that:

- If event A causes event B, A's timestamp is always less than B's
- Timestamps are closely related to physical time
- Clock skew between devices is handled gracefully

## HLC Implementation in the System

The system uses the `hybrid_logical_clocks` package:

```dart
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
```

### Initialization

HLC is initialized during database startup:

```dart
// In ClientDatabase
@override
MigrationStrategy get migration {
  return MigrationStrategy(
    beforeOpen: (details) async {
      // Get client ID
      final currentClient = 
          await clientDrift.usersDrift.getCurrentClient().getSingle();
      
      // Initialize HLC with client node
      HLC.initialize(clientNode: ClientNode(currentClient.id));
    },
  );
}

// In ServerDatabase
@override
MigrationStrategy get migration {
  return MigrationStrategy(
    beforeOpen: (details) async {
      // Initialize HLC with server node
      HLC.initialize(clientNode: ClientNode("server"));
    },
  );
}
```

Each node (client or server) is initialized with a unique identifier.

### Timestamp Generation

When creating new events, HLC provides the timestamp:

```dart
// Generate a new timestamp for an event
final event = Event(
  id: generateUuidV7String(),
  clientId: clientId,
  entityId: entityId,
  attribute: attribute,
  value: value,
  timestamp: HLC().sendPacked(), // HLC timestamp
);
```

The `sendPacked()` method:

1. Updates the local HLC with the current physical time
2. Increments the logical counter
3. Returns a string representation of the timestamp

### Message Exchange

When exchanging messages between nodes:

```dart
// In ServerDatabase.api.dart
Future<PostBundlesResponse> interpretIncomingAuthedPostBundlesQueryAndRespond(
    PostBundlesQuery query) async {
  // Update server HLC with client timestamp
  HLC().receivePacked(query.clientTimestamp);
  
  // Process bundles...
  
  // Return response with updated server timestamp
  return PostBundlesResponse(
    HLC().sendPacked(), // New server timestamp
    insertedBundleIds,
    newBundles,
  );
}
```

The `receivePacked()` method:

1. Parses the incoming timestamp
2. Updates the local HLC, considering both:
    - The incoming timestamp's physical time
    - The incoming timestamp's logical counter
    - The local physical time
3. This ensures the HLC moves forward and maintains causality

### Timestamp Format

HLC timestamps are represented as strings with the format:
`{physical_time}-{logical_counter}-{node_id}`

For example: `1678452389123-0-client1`

This format ensures:

- Chronological sorting by physical time
- Tie-breaking with logical counter
- Node identification for debugging

## HLC Usage in Event Ordering

The system uses HLC timestamps to establish a consistent order for events:

```sql
-- In attributes.drift
ON CONFLICT (entity_id, attribute) DO UPDATE
SET value = excluded.value,
    timestamp = excluded.timestamp
WHERE excluded.timestamp > attributes.timestamp;
```

This conflict resolution relies on the HLC timestamp comparison to determine
which event should win when there's a conflict.

## Causality Tracking

HLC ensures causality is preserved in several ways:

1. **Local Operations** - Events created by the same node have increasing
   timestamps
2. **Message Exchange** - When a node receives a message, its HLC is updated to
   be later than the sender's
3. **Derived Events** - Events triggered by a received event will have a later
   timestamp

For example:

```
Client A: Creates event E1 with timestamp T1
Client A: Sends E1 to Server
Server: Updates HLC with T1
Server: Creates event E2 with timestamp T2 (where T2 > T1)
Server: Sends E2 to Client B
Client B: Updates HLC with T2
Client B: Creates event E3 with timestamp T3 (where T3 > T2)
```

This chain ensures proper causality: E1 → E2 → E3

## Clock Skew Handling

HLC handles clock skew between devices:

1. If a node receives a timestamp with a physical time far in the future:
    - It will update its logical counter instead of jumping forward
    - This prevents issues from devices with incorrectly set clocks

2. If a node's physical clock moves backward (e.g., due to NTP adjustments):
    - The HLC will still move forward using the logical counter
    - This prevents causality violations

## Drift Persistence

In production systems, HLC states should be persisted to handle restarts:

```dart
// TODO: perhaps move to HLC not being a singleton but rather a database
// attribute
```

The code contains a comment indicating this is planned but not yet implemented.
Currently, HLC is reinitialized during database startup.

## Special HLC Values

The system uses special HLC values:

```sql
SELECT COALESCE(last_server_issued_timestamp, hlc_absolute_zero)
```

`hlc_absolute_zero` represents the earliest possible timestamp, used as a
default when no previous timestamp exists.

## Testing with HLC

For testing, the HLC state can be reset:

```dart
@visibleForTesting
static void cleanSlateForTesting() {
  HLC.reset();
}
```

This ensures tests have a clean HLC state.

## Advantages of HLC in This System

Using HLC provides several advantages:

1. **Distributed Consensus** - Consistent event ordering without central
   coordination
2. **Offline Operations** - Clients can work offline and correctly order events
3. **Conflict Resolution** - Clear policy for resolving concurrent updates
4. **Causality Preservation** - Events maintain their cause-effect relationships
5. **Clock Skew Tolerance** - System works even when device clocks differ

## Limitations and Considerations

Some limitations and considerations with HLC:

1. **String Representation** - Storing timestamps as strings isn't the most
   efficient
2. **Clock Drift** - Very large clock drift between nodes can affect operation
3. **Non-Persistence** - Currently, HLC state isn't persisted across restarts
4. **Node Identification** - Node IDs must be unique across the system

## HLC vs. Other Approaches

HLC was chosen over alternatives like:

1. **Wall-Clock Time** - Vulnerable to clock skew
2. **Lamport Clocks** - Lack relation to physical time
3. **Vector Clocks** - Higher overhead and complexity
4. **Server-Assigned Timestamps** - Require centralization

HLC provides a good balance of causality tracking, relation to real time, and
efficiency.
