# Synchronization Protocol

This document details the synchronization protocol used between clients and the server in the dart-drift-sync-packages system.

## Protocol Overview

The synchronization protocol is based on a RESTful API with JSON-serialized messages. The protocol enables:

- Event-based synchronization between clients and server
- Incremental updates to minimize bandwidth
- Authentication for secure data access
- Conflict resolution via timestamp ordering

## Message Types

The protocol defines several message types for different synchronization operations:

### Base Query and Response

All queries inherit from `BaseQuery` which provides authentication:

```dart
class BaseQuery {
  String userId;
  String token;
  String type;

  BaseQuery(this.userId, this.token, this.type);
}
```

All responses inherit from `QueryResponse` which includes the response type:

```dart
class QueryResponse<T> {
  String type;

  QueryResponse(this.type);
}
```

### Post Bundles

Used to send events from client to server and receive new events:

**Query:**
```dart
class PostBundlesQuery extends BaseQuery {
  String clientTimestamp;
  String lastIssuedServerTimestamp;
  List<Bundle> bundles;

  PostBundlesQuery(
    String userId,
    String token,
    this.clientTimestamp,
    this.lastIssuedServerTimestamp,
    this.bundles,
  ) : super(userId, token, "post_bundles_query");
}
```

**Response:**
```dart
class PostBundlesResponse extends QueryResponse<PostBundlesQuery> {
  String lastIssuedServerTimestamp;
  List<Bundle> newBundles;
  List<String> insertedBundleIds;

  PostBundlesResponse(
    this.lastIssuedServerTimestamp,
    this.insertedBundleIds,
    this.newBundles,
  ) : super("post_bundles_response");
}
```

### Get Bundle IDs

Used to request the IDs of all bundles available for a user:

**Query:**
```dart
class GetBundleIdsQuery extends BaseQuery {
  String? sinceTimestamp;

  GetBundleIdsQuery(
    String userId,
    String token,
    {this.sinceTimestamp}
  ) : super(userId, token, "get_bundle_ids_query");
}
```

**Response:**
```dart
class GetBundleIdsResponse extends QueryResponse<GetBundleIdsQuery> {
  List<String> bundleIds;

  GetBundleIdsResponse(this.bundleIds)
    : super("get_bundle_ids_response");
}
```

### Get Bundles

Used to request specific bundles by their IDs:

**Query:**
```dart
class GetBundlesQuery extends BaseQuery {
  List<String> bundleIds;

  GetBundlesQuery(
    String userId,
    String token,
    this.bundleIds,
  ) : super(userId, token, "get_bundles_query");
}
```

**Response:**
```dart
class GetBundlesResponse extends QueryResponse<GetBundlesQuery> {
  List<Bundle> bundles;

  GetBundlesResponse(this.bundles)
    : super("get_bundles_response");
}
```

## Synchronization Flows

The protocol supports multiple synchronization flows depending on client needs:

### Standard Sync Flow

The most common flow for regular synchronization:

1. **Client** prepares a `PostBundlesQuery` with:
   - Local events since last sync
   - Last server timestamp
   - Current client timestamp

2. **Server** processes the query:
   - Updates its HLC with client timestamp
   - Inserts client bundles
   - Retrieves new bundles for the client

3. **Server** sends `PostBundlesResponse` with:
   - New server timestamp
   - IDs of inserted bundles (for confirmation)
   - New bundles for the client

4. **Client** processes the response:
   - Updates last server timestamp
   - Marks local bundles as confirmed
   - Inserts new events from server bundles

### Full Resync Flow

Used when a client needs to get all data:

1. **Client** sends `GetBundleIdsQuery` without timestamp
2. **Server** returns all bundle IDs for the user
3. **Client** determines which bundles it's missing
4. **Client** sends `GetBundlesQuery` with missing IDs
5. **Server** returns requested bundles
6. **Client** processes all received bundles

### Incremental Resync Flow

Used for initial sync and recovery:

1. **Client** sends `GetBundleIdsQuery` with last timestamp
2. **Server** returns bundle IDs newer than timestamp
3. **Client** requests missing bundles
4. **Server** returns requested bundles
5. **Client** processes received bundles

## Bundle Structure

Bundles are the core transfer unit in the protocol:

```dart
class Bundle {
  String id;
  String userId;
  String timestamp;
  String? payload; // JSON-encoded event payload
}
```

The payload contains serialized events:

```dart
class EventPayload {
  List<Event> events;
  
  EventPayload({required this.events});
}

class Event {
  String id;
  String clientId;
  String entityId;
  String attribute;
  String value;
  String timestamp;
}
```

## Authentication

All protocol messages include authentication:

- `userId` - Identifies the user making the request
- `token` - Secret token for authentication

The server validates these credentials before processing any request.

## Time Synchronization

The protocol uses Hybrid Logical Clocks (HLC) for time synchronization:

1. Each message includes a timestamp
2. Server and clients maintain HLC instances
3. When receiving a message, the recipient updates its HLC
4. When sending a message, the sender includes its current HLC time
5. This ensures causal ordering of events across the distributed system

## Error Handling

The protocol includes error handling for various scenarios:

- Authentication failures return 401 Unauthorized
- Invalid requests return 400 Bad Request
- Server errors return 500 Internal Server Error
- Each error includes a descriptive message

## Implementation Considerations

### HTTP Transport

The protocol is typically implemented over HTTP:

```dart
final response = await http.post(
  Uri.parse(serverUrl),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(query.toJson()),
);

if (response.statusCode == 200) {
  final queryResponse = QueryResponse.fromJson(jsonDecode(response.body));
  // Process response
}
```

### Serialization

All protocol messages use JSON serialization with the `json_annotation` package:

```dart
@JsonSerializable(fieldRename: FieldRename.snake)
class ExampleMessage {
  // Properties

  factory ExampleMessage.fromJson(Map<String, dynamic> json) =>
      _$ExampleMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleMessageToJson(this);
}
```

### Batching

To optimize performance:
- Events are batched into bundles
- Multiple bundles can be sent in a single request
- Responses may include multiple bundles

### Idempotency

The protocol is designed to be idempotent:
- Duplicate bundle insertions are ignored
- Bundle IDs provide deduplication
- Event IDs ensure unique events

## Security Considerations

The protocol includes several security features:

- All communication should use HTTPS in production
- User authentication prevents unauthorized access
- User-scoped data access prevents data leakage
- Input validation prevents malformed requests

## Protocol Extensions

The protocol can be extended to support:

- Different event types
- More complex conflict resolution
- Multi-user collaboration
- Selective synchronization
- Compression for large payloads