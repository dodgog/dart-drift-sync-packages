# Server Architecture

This document details the server-side architecture of the
dart-drift-sync-packages system, focusing on the central database, API
endpoints, and event processing capabilities.

## Server Database Structure

The server database is the central source of truth for the system. It is defined
in the `ServerDatabase` class, which can use either SQLite (for
development/testing) or PostgreSQL (for production) as its underlying storage
engine.

The database is responsible for:

- Storing all events from all clients
- Authenticating users and clients
- Processing sync requests
- Distributing events to appropriate clients

## Key Components

### Database Core

The `ServerDatabase` class (`src/server_database/database.dart`) implements
the `ServerDatabaseInterface`:

```dart
@DriftDatabase(
  include: {'package:backend/server.drift'},
)
class ServerDatabase extends $ServerDatabase
    implements ServerDatabaseInterface {
  
  // Internal constructor with full access
  @visibleForTesting
  ServerDatabase({
    this.initialConfig,
    QueryExecutor? executor,
    File? file,
  }) : super(executor ?? _openConnection(file: file));

  // Public factory for creating properly encapsulated instances
  static ServerDatabaseInterface create({
    ServerDatabaseConfig? initialConfig,
    QueryExecutor? executor,
    File? file,
  }) {
    return ServerDatabase(
      initialConfig: initialConfig,
      executor: executor,
      file: file,
    );
  }
  
  // ...additional implementation
}
```

The database can be initialized with:

- In-memory storage (for testing)
- File-based SQLite (for development)
- PostgreSQL connection (for production, via appropriate executor)

### Interface Layer

The `ServerDatabaseInterface` (`src/server_database/interface.dart`) defines the
public API that server implementations expose:

```dart
abstract class ServerDatabaseInterface {
  // Initialize the database
  Future<void> initialize();
  
  // Process and respond to client queries
  Future<Map<String, dynamic>> interpretQueryAndRespond(
      Map<String, dynamic> parsedJsonMap);
      
  // Create a new authenticated user and client
  Future<void> createAuthedUserAndClient(
      String userId, String userName, String clientId, String token);
}
```

This interface ensures a clean separation between the internal database
implementation and the external API surface.

### Authentication

Authentication (`src/server_database/auth.dart`) handles:

- User credential verification
- Token validation
- Security checks for API requests

### API Processing

The `Api` extension (`src/server_database/api.dart`) processes client requests:

- `interpretIncomingAuthedPostBundlesQueryAndRespond()` - Handles event posting
- `interpretIncomingAuthedGetBundleIdsAndRespond()` - Returns available bundle
  IDs
- `interpretIncomingAuthedGetBundlesAndRespond()` - Returns requested bundles

## Internal Operations

The server internally manages data using several modules:

### Configuration

Server configuration (`src/server_database/internal/config.dart`) stores:

- Database settings
- HLC (Hybrid Logical Clock) initialization

### CRUD Operations

Internal CRUD operations (`src/server_database/internal/crud.dart`):

- `insertBundles()` - Add bundles to the database
- Database manipulation utilities

### Read Operations

Internal read operations (`src/server_database/internal/read.dart`):

- `getUserBundlesSinceOptionalTimestamp()` - Get bundles for a user
- `getUserBundleIdsSinceOptionalTimestamp()` - Get bundle IDs for a user
- `getBundlesWhereIdInList()` - Retrieve specific bundles

## Query Processing Flow

When a client sends a request, the server processes it following these steps:

1. **Authentication**
   ```dart
   final baseQuery = BaseQuery.fromJson(parsedJsonMap);
   final isAuthorized = await verifyUser(baseQuery.userId, baseQuery.token);
   if (!isAuthorized) {
     throw UnauthorizedException('Invalid user credentials');
   }
   ```

2. **Query Routing**
   ```dart
   switch (baseQuery.type) {
     case "post_bundles_query":
       return (await interpretIncomingAuthedPostBundlesQueryAndRespond(
               baseQuery as PostBundlesQuery))
           .toJson();
     case "get_bundle_ids_query":
       // Handle bundle IDs query
     case "get_bundles_query":
       // Handle bundles query
     default:
       throw UnrecognizedQueryException(
           'Unrecognized query type: ${baseQuery.type}');
   }
   ```

3. **Event Processing** (for post_bundles_query)
   ```dart
   // Update server HLC with client timestamp
   HLC().receivePacked(query.clientTimestamp);

   // Insert bundles
   final insertedBundleIds = await insertBundles(query.bundles);

   // Get events the client needs
   final newBundles = await getUserBundlesSinceOptionalTimestamp(
     query.userId,
     query.lastIssuedServerTimestamp,
   );

   // Return response
   return PostBundlesResponse(
     HLC().sendPacked(),
     insertedBundleIds,
     newBundles.where((e) => !insertedBundleIds.contains(e.id)).toList(),
   );
   ```

## Server Deployment

The server application (`server/bin/server.dart`) implements:

- HTTP API for clients
- JSON request/response handling
- Database initialization
- Error handling and logging

Example server implementation structure:

```dart
void main() async {
  // Initialize server database
  final db = ServerDatabase.create(
    initialConfig: ServerDatabaseConfig(isServer: true),
    // Configure for appropriate database (SQLite or PostgreSQL)
  );
  await db.initialize();
  
  // Set up HTTP server
  final app = HttpServer.bind('0.0.0.0', 8080);
  app.listen((request) async {
    if (request.method == 'POST') {
      // Process client request
      final data = await utf8.decoder.bind(request).join();
      final parsedJson = jsonDecode(data);
      
      try {
        // Process query through database
        final response = await db.interpretQueryAndRespond(parsedJson);
        
        // Send response
        request.response
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(response))
          ..close();
      } catch (e) {
        // Handle errors
        request.response
          ..statusCode = 500
          ..write('Error: $e')
          ..close();
      }
    }
  });
}
```

## Time Handling

Server time handling is crucial for ensuring proper event ordering:

- Hybrid Logical Clocks (HLC) track event causality across distributed clients
- Server timestamp becomes the authoritative ordering for events
- HLC ensures events maintain causality even with clock skew
- Server assigns final timestamps to all events

## PostgreSQL Support

For production deployments, the server typically uses PostgreSQL:

- SQL queries are compatible with PostgreSQL
- Drift generates appropriate SQL for the target database
- Connection handling uses appropriate executor
- The system includes a Docker configuration for PostgreSQL

## Error Handling

The server implements robust error handling:

- `UnauthorizedException` - For authentication failures
- `UnrecognizedQueryException` - For invalid requests
- `DatabaseInitException` - For initialization problems

## Security Considerations

The server implementation includes security features:

- Token-based authentication
- User-scoped data access
- Input validation

## Testing

The server includes tests for:

- In-memory database operations
- PostgreSQL integration
- API request handling
- Authentication
- Error conditions
