# Drift Database Usage

This document details how the Drift database library is used in the
dart-drift-sync-packages system, explaining the schema design, query
construction, and database operations.

## Drift Overview

[Drift](https://drift.simonbinder.eu/) (formerly Moor) is a reactive persistence
library for Dart/Flutter that wraps SQLite and provides:

- Type-safe SQL query generation
- Database schema definition in SQL
- Reactive streams for query results
- Compile-time generated code for database access
- Cross-platform support (Android, iOS, desktop, web)

## Schema Definition

In this system, database schemas are defined in `.drift` files using SQL:

```sql
-- Example from shared_bundles.drift
CREATE TABLE bundles (
    id TEXT NOT NULL PRIMARY KEY,
    user_id TEXT NOT NULL REFERENCES users (id),
    timestamp TEXT NOT NULL,
    payload TEXT
);
```

These files are processed by the Drift code generator to produce Dart classes.

## Database Classes

Each database is defined with a Dart class annotated with `@DriftDatabase`:

```dart
@DriftDatabase(
  include: {'package:backend/client.drift'},
)
class ClientDatabase extends $ClientDatabase {
  ClientDatabase({
    this.initialConfig,
    QueryExecutor? executor,
    File? file,
  }) : super(executor ?? _openConnection(file: file));
  
  // Additional implementation...
}
```

The `include` parameter specifies which `.drift` files to include in the schema.

## Drift Code Generation

The system uses Drift's code generation extensively:

1. **Build Setup** - Configuration in `build.yaml`:
   ```yaml
   targets:
     $default:
       builders:
         drift_dev:drift_dev:
           options:
             generate_connect_constructor: true
             sql:
               dialect: sqlite
   ```

2. **Generated Files** - For each `.drift` file, Drift generates:
    - Table classes
    - Data classes
    - Query methods
    - Database accessors

3. **Extension Pattern** - The system uses extensions to organize database
   operations:
   ```dart
   extension Api on ClientDatabase {
     // API methods...
   }
   
   extension Crud on ClientDatabase {
     // CRUD operations...
   }
   ```

## Database Operations

### Query Construction

The system uses Drift's type-safe query builder:

```dart
// Select query example (derived from codebase understanding)
Future<List<Event>> getLocalEventsA() async {
  return await (select(eventsTable)
    ..where((t) => t.timestamp.isGreaterThan(lastServerTimestamp)))
    .get();
}

// Insert query example
Future<int> insertLocalEvent(Event event) async {
  return await into(eventsTable).insert(
    EventsCompanion.insert(
      id: event.id,
      clientId: event.clientId,
      entityId: event.entityId,
      attribute: event.attribute,
      value: event.value,
      timestamp: event.timestamp,
    ),
    onConflict: DoNothing(),
  );
}
```

### Raw SQL Queries

For complex queries, the system uses raw SQL within `.drift` files:

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
WHERE e2.entity_id IS NULL;
```

These are accessed in Dart code:

```dart
await clientDrift.eventsDrift.insertAllEventsIntoAttributes();
```

### Transactions

The system uses transactions for atomic operations:

```dart
await transaction(() async {
  if (bundlesPersistedToServer != null) {
    registerBundlesPersistedToServerWithoutPayload(
        bundlesPersistedToServer.toList());
  }

  await insertNewEventsFromNewBundles(response.newBundles);
  await interpretIssuedServerTimestamp(response.lastIssuedServerTimestamp);
});
```

## Multi-Database Architecture

The system has a sophisticated multi-database architecture:

### 1. Shared Schema Components

Shared tables used by both client and server:

```dart
// shared_database.dart exports
export 'src/shared_database/database_config.dart';
```

### 2. Client Database

Client-specific database implementation:

```dart
// client_database.dart exports
export 'src/client_database/database.dart';
export 'src/client_database/api.dart';
export 'src/client_database/crud.dart';
export 'src/client_database/config.dart';
```

### 3. Server Database

Server-specific database implementation:

```dart
// server_database.dart exports
export 'src/server_database/api.dart';
export 'src/server_database/internal/config.dart';
export 'src/server_database/database.dart';
```

## Database Configuration and Initialization

### Client Initialization

```dart
final clientDb = ClientDatabase(
  initialConfig: ClientDatabaseConfig(
    userId: "user123",
    userToken: "token123",
  ),
  // Use in-memory database for testing
  // Or file for persistence
  file: File('client.db'),
);

// Initialize
await clientDb.ensureInitialized();
```

### Server Initialization

```dart
final serverDb = ServerDatabase.create(
  initialConfig: ServerDatabaseConfig(isServer: true),
  // Can use SQLite or connect to PostgreSQL
  executor: postgresExecutor,
);

// Initialize
await serverDb.initialize();
```

## Database Executors

The system supports multiple database backends:

### SQLite (via drift/native)

```dart
static QueryExecutor _openConnection({File? file}) {
  if (file != null) {
    return NativeDatabase.createInBackground(file);
  } else {
    return NativeDatabase.memory();
  }
}
```

### PostgreSQL Support

For production server deployments, the system can use PostgreSQL:

```dart
// Example PostgreSQL connection (not directly in codebase but implied)
final connection = PostgreSQLConnection(
  'localhost', 5432, 'database',
  username: 'user',
  password: 'password',
);
await connection.open();

final executor = PostgreSQLExecutor(connection);
final db = ServerDatabase.create(executor: executor);
```

## Migration Handling

The system implements migration strategies for schema upgrades:

```dart
@override
int get schemaVersion => 1;

@override
MigrationStrategy get migration {
  return MigrationStrategy(
    beforeOpen: (details) async {
      if (details.wasCreated) {
        await initializeClientWithInitialConfig();
      }
      
      // Additional initialization...
      HLC.initialize(clientNode: ClientNode(currentClient.id));
    },
  );
}
```

## Nested Database Structure

The system uses a nested database structure:

```dart
// Client database has access to shared components
final sharedBundles = await clientDrift.sharedDrift.sharedBundlesDrift.insertBundle(
  id: bundle.id,
  userId: bundle.userId,
  timestamp: bundle.timestamp,
  payload: null,
);
```

This structure allows for:

- Code organization
- Shared components between client and server
- Modular development

## JSON Integration

Drift is integrated with JSON serialization:

```dart
// Convert events to JSON for bundle payload
final bundle = Bundle(
  id: generateUuidV7String(),
  userId: config.userId!,
  timestamp: HLC().sendPacked(),
  payload: jsonEncode(EventPayload(events: events).toJson()),
);

// Extract events from JSON payload
final events = EventPayload.fromJson(jsonDecode(bundle.payload!)).events;
```

## Type Converters

The system uses Drift's type converters for serialization:

```dart
// Example derived from understanding of bundle_converter.dart
@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class BundleConverter implements j.JsonConverter<Bundle, Map<String, dynamic>> {
  const BundleConverter();

  @override
  Bundle fromJson(Map<String, dynamic> json) => Bundle.fromJson(json);

  @override
  Map<String, dynamic> toJson(Bundle object) => object.toJson();
}
```

## Testing Approach

The system includes testing utilities for databases:

```dart
@visibleForTesting
static void cleanSlateForTesting() {
  HLC.reset();
}

// Example test (derived from codebase understanding)
test('Test event insertion and retrieval', () async {
  final db = ClientDatabase(initialConfig: testConfig);
  await db.ensureInitialized();
  
  // Insert test event
  final event = Event(...);
  await db.insertLocalEvent(event);
  
  // Verify insertion
  final events = await db.getEvents();
  expect(events.length, 1);
  expect(events.first.id, event.id);
});
```

## Performance Considerations

The Drift implementation includes performance optimizations:

1. **Indices** for frequently queried fields:
   ```sql
   CREATE INDEX event_client_id_index ON events(client_id);
   ```

2. **Batched operations** for efficiency:
   ```dart
   await transaction(() async {
     for (final event in newEvents) {
       await clientDrift.insertLocalEventWithClientId(event);
     }
   });
   ```

3. **Optimized queries** using WHERE clauses:
   ```sql
   getLocalEventsToPush:
   SELECT e.*
   FROM events e
   WHERE e.timestamp > (
     SELECT COALESCE(last_server_issued_timestamp, hlc_absolute_zero)
     FROM config
     LIMIT 1
   );
   ```

## Drift Integration with Flutter

In Flutter applications, Drift is integrated with the UI layer:

```dart
class DataSyncService extends ChangeNotifier {
  final String serverUrl;
  final ClientDatabase db;

  DataSyncService({required this.serverUrl, required this.db});

  Future<void> sync() async {
    // Sync implementation
    notifyListeners();
  }
}
```

This enables reactive UI updates when database changes occur.
