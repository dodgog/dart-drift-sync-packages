# FEEDBACK

## ORGANIZATION / STRUCTURE

- Clearer file structure and organization: it's confusing to parse out exactly what the different surfaces / parts of the codebase are and how they're interelated by looking at the file structure. there's lots of repetition of `server` and `client` keywords which can get overwhelming and overload the top level namespace. also `backend` and `server` as top level folders is confusing too.

- Feels like `server_database` should be part of the `server` package and not the `backend` since it's handling server database setup and config which the shared `backend` package doesn't reuse.

- Separate out and organize SQL drift files:
    `client_definitions/users.drift` has config info which should be in `client/definitions/config.drift`

- Barrel files: move barrel files to sub folders so the root folder is not cluttered

```
    backend/lib/
    ├── src/
    │   ├── core/                              # Core shared functionality
    │   │   ├── database/                      # Common database functionality
    │   │   │   ├── config.dart                # Database configuration
    │   │   │   └── interface.dart             # Common interfaces
    │   │   ├── models/                        # Shared data models
    │   │   │   ├── bundles.dart
    │   │   │   └── users.dart
    │   │   └── utils/                         # Shared utilities
    │   │       ├── converters/                # Type converters
    │   │       │   ├── bundle_converter.dart
    │   │       │   └── event_converter.dart
    │   │       └── encoders/
    │   │           └── event_payload_encoder.dart
    │   │
    │   ├── client/                            # Client-side functionality
    │   │   ├── database/                      # Client database implementation
    │   │   │   ├── api.dart
    │   │   │   ├── crud.dart
    │   │   │   ├── database.dart
    │   │   │   ├── read.dart
    │   │   │   └── setup.dart
    │   │   ├── definitions/                   # Client data definitions
    │   │   │   ├── schema/                    # Database schema
    │   │   │   │   ├── attributes.drift
    │   │   │   │   ├── events.drift
    │   │   │   │   └── users.drift
    │   │   │   └── nodes/                     # Node-related definitions
    │   │   │       ├── attributes.dart
    │   │   │       ├── types.dart
    │   │   │       └── helpers/
    │   │   │           ├── apply.dart
    │   │   │           └── issue.dart
    │   │   └── index.dart                     # Barrel file for client exports
    │   │
    │   ├── server/                            # Server-side functionality
    │   │   ├── database/                      # Server database implementation
    │   │   │   ├── api.dart
    │   │   │   ├── auth.dart
    │   │   │   ├── crud.dart
    │   │   │   ├── database.dart
    │   │   │   └── read.dart
    │   │   ├── definitions/                   # Server data definitions
    │   │   │   ├── schema/                    # Database schema
    │   │   │   │   ├── bundles.drift
    │   │   │   │   └── users.drift
    │   │   │   └── models/                    # Server-specific models
    │   │   └── index.dart                     # Barrel file for server exports
    │   │
    │   ├── messaging/                         # Communication between client/server
    │   │   ├── api/                           # API endpoints
    │   │   │   ├── bundles/
    │   │   │   │   ├── get_bundles.dart
    │   │   │   │   ├── get_bundle_ids.dart
    │   │   │   │   └── post_bundles.dart
    │   │   │   └── users/
    │   │   └── base/                          # Base messaging classes
    │   │       ├── base_query.dart
    │   │       └── base_query_response.dart
    │   │
    │   └── utils/                             # Utilities
    │       └── benchmarks/                    # Benchmarking tools
    │           └── benchmark_events.dart
    │
    ├── client_database.dart                   # Public API barrel files
    ├── client_definitions.dart
    ├── server_database.dart
    ├── server_definitions.dart
    └── messaging.dart
```

----------------------------

## INTERFACES / APIs

### Shared (Server + Client)

- I think we should separate out types and schemas between db server and client — it's a cleaner set of APIs. The redundancy is ok, and we should not overoptimize initially, and do it at scale IF it's even possible then. (my guess is that we'd need to build our own custom tooling). We should optimize for separation of concerns and maintainabiliyuty — the reliability of shared types can be made up for by writing a set of solid tests (unit, integration, etc.)

- Server + Client Database interfaces: don't think we really need these abstract classes since it's just two functions and only one class is implementing each of them

- extending `ServerDatabase` and `ClientDatabase`: not really sure about extensions on `ServerDatabase` and `ClientDatabase` to add `Read`, `Crud`, `Api`, etc. makes it hard to reason about because it feels like there's not really a clear separation of concerns between the server, middleware, and db layers blending into each other. would suggest something a Service pattern to clearly capture / centralize all the middlware and business logic related to the bundles:

```dart
// Define service interfaces
abstract class BundleService {
  Future<List<String>> insertBundles(List<Bundle> bundles);
  Future<List<Bundle>> getUserBundlesSince(String userId, String? timestamp);
  // other bundle methods
}

// Implement with database access
class BundleServiceImpl implements BundleService {
  final ServerDatabase _db;

  BundleServiceImpl(this._db);

  @override
  Future<List<String>> insertBundles(List<Bundle> bundles) async {
    // Implementation using _db
  }

  // other implementations
}

// Server uses services instead of direct DB access
class Server {
  final BundleService bundleService;

  Server(ServerDatabase db) : bundleService = BundleServiceImpl(db);

  Future<BundlesResponse> handleBundles(BundlesQuery query) async {
    final insertedIds = await bundleService.insertBundles(query.bundles);
    // rest of implementation
  }
}
```

- Expose API endpoints using REST principles: i don't think we should use custom `interpretQueryAndRespond` type methods to handle requests
    - it's not intuitive and as a dev with backend experience, found it confusing to figure out why / how to make a request vs. just having very clear routing and handlers
    - unless there's a very good reason to do non-standard stuff, we should avoid it since it makes it harder to scale the codebase in the future
    - makes it harder to document and build clients for conform to the OpenAPI spec, etc.
    - don't need to reimplement standard web GET, POST, etc. with `get_bundle_ids_query`, `post_bundles_query`
    - gRPC might be a good use case here if we want to use more of a function calling approach

----------------------------

## DETAILS

- Accessing db queries: `serverDrift.sharedDrift.sharedBundlesDrift.insertBundle` isn't the most ergonomic — anything we can do to simplify?

- Really long descriptors: like `interpretIncomingAuthedPostBundlesQueryAndRespond` make it hard to read and navigate the through the codebase — not all info should be jammed into names and additional info can be inferred from the surrounding context (comments, class, folder, package).
    - `getUserBundleIdsSinceOptionalTimestamp`: SinceOptionalTimestamp part can be captured by the function definition
    - `Future<List<BundleId>> getBundleIds(String userId, Timestamp? since)`
    - `interpretIssuedServerTimestamp`: too literal of a name, functions are supposed to abstract complexity so names should do that too (to the extent where it doesn't end up being super vague), something like `updateLastSyncTimestamp` seems more reasonable
    - same `registerBundlesPersistedToServerWithoutPayload` and `insertNewEventsFromNewBundles`

> AI: The function name `interpretIssuedServerTimestamp` has several issues:
> - Too verbose - It's unnecessarily long at 29 characters
> - Unclear action - "Interpret" is vague; the function actually stores/updates a timestamp
> - Implementation details - "Issued" exposes implementation details
> - Missing context - Doesn't indicate where the timestamp comes from or what it's for

- `config` table values should be stored as a KV store, it's standard pratice

```sql
CREATE TABLE config_values (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
```

> AI: The benefits are well-understood:
> - Avoids database migrations for new settings
> - Makes backup/restore of settings straightforward
> - Allows for programmatic management of settings
> - Enables hierarchical settings with prefixed keys
> The main tradeoff is type safety, which is usually handled in application code instead of at the database level.

- Improve ergonomics: `insertNewEventsFromNewBundles` function
- Improve ergonomics: `registerBundlesPersistedToServerWithoutPayload` function

----------------------------

## NIT PICKS:

- `_putDataHandler`: don't need to add the method to the function name, rename to something like _handleDataRequest since it's standard web server practice

- `DatabaseConfig`: don't think we need to over-optimize and create this shared config, since there's no need to have a shared class in the current uses

- SQL optimization
    - `getBundlesWhereIdInList`: use SQL 'IN' instead of using a for loop
        - `SELECT * FROM bundles WHERE id IN ('id1', 'id2', 'id3', ...);`
    - `insertBundles`: use batched insert instead of for loop

- Document and explicitly call out HLC operations:
    - `HLC().receivePacked(query.clientTimestamp);`
    - `HLC().sendPacked(),`

----------------------------

## EXPLAIN

- `JsonCommunicator`?
