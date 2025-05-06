# Dart Drift Sync Packages

A collection of Dart libraries and sample apps that together implement a state-based, event-driven (append-only) CRDT backed by Drift.

## Repository layout

- `backend/`
  - `lib/`
    - `src/client/` – logic that lives on the client (mobile / desktop / always on client on web)
      - `client_database/` – database instantiation, sync service, everything to connect sqlite to user-facing api.
      - `core_data_interface/` – a user-facing api like Apple's Core Data one
      - `client_definitions/` – event & attribute models
    - `src/server/` – full server implementation to facilitate client
      - `server_database/` – Drift DB and high-level logic (`interpretIncomingAuthedPostBundlesQueryAndRespond`)
      - `server_definitions/` – defines server ORM logic 
    - `src/shared/` – code used by both client and server
      - `shared_definitions/` – Drift tables (bundles, users) replicated on both ends so they share a single schema
      - `messaging/` – typed JSON DTOs (queries & responses) that flow over the wire between client and server, e.g. `PostBundlesQuery`, `GetBundlesResponse`
  - `test/` – executable documentation
    - `client/` – verifies client-side behaviour (event emission, conflict resolution, sync)
    - `server/` – drives the in-memory & Postgres server implementations and checks end-to-end semantics
    - To run server tests, spool up the Postgres server using the `run-postgres.sh` script
    - Run all tests with `flutter test`.


## How to read the code

1. Start with `backend/test/client/` tests
2. `client-example-app/` – a tiny Flutter app that shows how to consume the client backend. See `lib/main.dart` for the API in action. To run execute `flutter run -d macos` in its folder.
3. For a deeper dive, explore `backend/lib/src/client/client_definitions/` and `backend/lib/src/client/client_database/`
4. You can launch the Dart server to play around by running `dart run server.dart` (also spool up Postgres with `run-postgres.sh`).


