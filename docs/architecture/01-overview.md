# Dart Drift Sync Packages: System Architecture Overview

This document provides a high-level overview of the dart-drift-sync-packages
project, its purpose, architecture, and components.

## Project Purpose

This project is a package ensemble that implements a client-server database
synchronization system using an event-driven approach. It's designed to provide
a reusable architecture for state-based event-driven synchronization with the
following key features:

- Append-only log for events
- CRDT (Conflict-free Replicated Data Type) capabilities
- Client-server synchronization
- Event sourcing pattern

The system allows for efficient state replication between a server (source of
truth) and multiple clients, implementing an event-based synchronization
pattern.

## Architectural Pattern: Event Sourcing

The project implements the Event Sourcing pattern, where:

1. All changes to application state are stored as a sequence of events
2. Events are immutable facts that describe what happened
3. The current state can be recreated by replaying events
4. The event log is the source of truth

This approach offers several benefits:

- Complete audit history
- Ability to recreate past states
- Natural fit for CRDT operations
- Scalability for distributed systems

## High-Level Architecture

The system is divided into three main components:

1. **Backend Package**: Core library containing:
    - Database schema definitions
    - Client database implementation
    - Server database implementation
    - Shared data structures
    - Messaging protocol

2. **Server**: REST API server for clients to connect to
    - Handles authentication
    - Processes sync queries
    - Manages the central database

3. **Client-View**: Flutter application demonstrating client-side implementation
    - User interface for testing synchronization
    - Local database with sync capabilities

## Data Flow

The synchronization follows these steps:

1. Clients generate events locally and store them in their database
2. During sync, clients send their new events to the server
3. Server processes these events and merges them with its database
4. Server returns any new events from other clients
5. Clients incorporate server-provided events into their local state

## Database Structure

The system uses SQLite (via Drift) on the client and can use either SQLite or
PostgreSQL on the server. The schema includes:

- Events table (recording all changes)
- Attributes table (current state derived from events)
- Bundles table (for grouping events during sync)
- Users/Auth tables (for authentication)

## Time Synchronization

The system uses Hybrid Logical Clocks (HLC) to handle time synchronization
across distributed clients, ensuring a consistent ordering of events even when
devices have clock skew.

## Next Sections

The subsequent documentation files provide detailed information about:

1. Client architecture
2. Server architecture
3. Synchronization protocol
4. Data schemas
5. Implementation patterns
