# Client Architecture

This document details the client-side architecture of the
dart-drift-sync-packages system, focusing on the local database, event
generation, and synchronization capabilities.

## Client Database Structure

The client database is implemented using Drift (formerly Moor), a reactive
persistence library for Dart. The client database is defined in
the `ClientDatabase` class, which:

- Uses SQLite as the storage engine
- Maintains local event log
- Stores current state in attributes table
- Handles local event generation and processing
- Manages sync state with the server

## Key Components

### Database Core

The `ClientDatabase` class (`src/client_database/database.dart`) is the
foundation of the client architecture:

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
  
  // ...implementation details
}
```

The database can be initialized with:

- In-memory storage (for testing)
- File-based storage (for production)
- Initial configuration parameters

### Configuration

Client configuration (`src/client_database/config.dart`) stores critical sync
information:

- User ID and authentication token
- Last server timestamp (for incremental sync)
- Client ID (for identifying this device)
- Hybrid Logical Clock initialization data

### API Layer

The `Api` extension (`src/client_database/api.dart`) provides methods for
interaction with the server:

- `pushEvents()` - Prepares local events for sending to server
- `pullEvents()` - Processes events received from server
- `requestAllServerBundleIds()` - Requests all bundle IDs from server
- `getMissingBundleIds()` - Determines which bundles are missing locally
- `requestBundles()` - Requests specific bundles from server
- `interpretRequestedBundles()` - Processes bundles received from server

### CRUD Operations

The `Crud` extension (`src/client_database/crud.dart`) handles database
operations:

- `interpretIssuedServerTimestamp()` - Updates sync timestamp
- `insertNewEventsFromNewBundles()` - Adds new events from server
- `registerBundlesPersistedToServerWithoutPayload()` - Records which bundles
  were confirmed

### Setup and Initialization

The client requires proper initialization (`src/client_database/setup.dart`):

- Database schema creation
- Initial client and user configuration
- HLC (Hybrid Logical Clock) initialization

## Event Handling Flow

### Event Generation

1. Application code creates an event
2. Event is assigned:
    - UUID
    - Client ID
    - Current timestamp (from HLC)
    - Entity ID and attribute
    - Value

3. Event is stored in the local events table
4. Attribute table is updated to reflect new value

### Event Processing

1. When new events arrive from the server:
    - Events are stored in the events table
    - Attributes table is updated based on timestamp ordering
    - Last server timestamp is updated

2. Conflict resolution is handled automatically:
    - Last-write-wins based on timestamps
    - HLC ensures proper causality across devices

## Query Access

Client database provides several query interfaces:

- Direct access to events and attributes tables
- Helper methods for common operations
- Event reduction to current state

Example query pattern:

```dart
// Get all attributes for an entity
final attributes = await (select(attributesTable)
  ..where((t) => t.entityId.equals(entityId)))
  .get();

// Get events after a timestamp
final events = await (select(eventsTable)
  ..where((t) => t.timestamp.isGreaterThan(timestamp)))
  .get();
```

## Synchronization Process

The client sync process (`client-view/lib/sync.dart`) occurs in these steps:

```dart
// 1. Prepare local events for sending
final postQuery = await db.pushEvents();

// 2. Send events to server
final response = await http.post(
  Uri.parse(serverUrl),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(postQuery.toJson()),
);

// 3. Process server response
final postResponse = PostBundlesResponse.fromJson(
  jsonDecode(response.body),
);
await db.pullEvents(postResponse);
```

This process:

1. Collects all local events since last sync
2. Packages them into a bundle
3. Sends them to the server
4. Receives confirmation and new events from server
5. Incorporates new events into local state

## Client-Side Libraries

The client depends on several libraries:

- `drift` - For database operations
- `hybrid_logical_clocks` - For distributed timestamp generation
- `uuidv7` - For time-ordered unique IDs
- `http` - For network communication with server

## Error Handling and Resilience

The client implementation includes error handling for:

- Network failures during sync
- Initialization errors
- Invalid server responses
- Conflict resolution issues

## Integration with Flutter

In a Flutter application (`client-view`), the client is typically:

1. Initialized during app startup
2. Wrapped in a provider for dependency injection
3. Sync is triggered:
    - Periodically
    - On network reconnection
    - On user action

The `DataSyncService` class provides a Flutter-friendly wrapper with change
notification:

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

## Testing

The client implementation includes tests for:

- Basic CRUD operations
- Event synchronization
- Conflict resolution
- Attribute updates
- Bulk operations
