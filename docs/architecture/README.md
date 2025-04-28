# Dart Drift Sync Packages Architecture Documentation

This directory contains comprehensive documentation on the architecture of the
dart-drift-sync-packages project, a system for event-driven data synchronization
between client and server using Drift databases.

## Documentation Index

1. [**Overview**](./01-overview.md) - High-level introduction to the system
   architecture
2. [**Data Model**](./02-data-model.md) - Details of the database schema and
   entity relationships
3. [**Client Architecture**](./03-client-architecture.md) - Client-side database
   and synchronization
4. [**Server Architecture**](./04-server-architecture.md) - Server-side
   implementation and API handling
5. [**Synchronization Protocol**](./05-synchronization-protocol.md) - How data
   is synchronized between clients and server
6. [**Event Sourcing Pattern**](./06-event-sourcing-pattern.md) - Implementation
   of the event sourcing architectural pattern
7. [**Drift Usage**](./07-drift-usage.md) - How the Drift database library is
   utilized
8. [**Hybrid Logical Clocks**](./08-hybrid-logical-clocks.md) - Distributed time
   synchronization mechanism
9. [**Future Directions**](./09-future-directions.md) - Potential future
   enhancements and roadmap

## System Overview

The dart-drift-sync-packages system is a package ensemble that implements a
client-server database synchronization system using an event-driven approach.
Key features include:

- Event-sourcing architecture with append-only event logs
- CRDT (Conflict-free Replicated Data Type) capabilities
- Drift (SQLite) databases on both client and server
- Hybrid Logical Clocks for distributed time synchronization
- RESTful API for client-server communication
- Flutter integration for client applications

The system consists of three main components:

1. **Backend Package** - Core library with database definitions and logic
2. **Server** - API server for handling client connections
3. **Client-View** - Flutter application demonstrating client usage

## Getting Started

To understand how this system works, we recommend reading the documentation in
the order listed above. For developers looking to use or contribute to the
project, the following sections are particularly helpful:

- **Overview** - For understanding the high-level architecture
- **Client Architecture** - For integrating the client into applications
- **Synchronization Protocol** - For understanding the data flow
- **Future Directions** - For contributing to the project's development
