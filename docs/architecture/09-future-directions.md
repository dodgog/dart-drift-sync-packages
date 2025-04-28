# Future Directions

This document outlines potential future directions and enhancements for the
dart-drift-sync-packages system, based on TODOs and comments found in the
codebase and logical next steps for this architecture.

## Current Limitations and TODOs

The existing codebase contains several TODOs and commented areas for future
improvement:

### Hybrid Logical Clock Persistence

```dart
// TODO: perhaps move to HLC not being a singleton but rather a database
// attribute
```

The current implementation initializes HLC on database startup but doesn't
persist its state. Future enhancements should store HLC state in the database to
handle restarts properly.

### Bundle-Event Relationship

```dart
// THINK: maybe store events which the client thinks are in this bundle
// THINK: maybe a table which would relate events to bundles
```

Currently, bundles and events have a somewhat loose relationship. A future
enhancement could include explicit tracking of which events belong to which
bundles.

### Server Timestamp Issuance

```dart
// TODO get the last issued timestamp to ensure continuous issuance
```

The server currently initializes HLC without considering previously issued
timestamps. This could be improved to ensure continuous and monotonic timestamp
issuance.

### Bundle ID Assignment

```dart
// THINK: at which point should we create this id? maybe the server
// should assign it
```

There's an open question about whether bundle IDs should be assigned by clients
or the server. This design decision could be revisited.

## Architectural Enhancements

### 1. CRDT Data Structures

The system is designed as a foundation for Conflict-free Replicated Data Types (
CRDTs), but doesn't yet implement specific CRDT data structures. Future
enhancements could include:

- **List CRDT** - For collaborative lists/arrays
- **Text CRDT** - For collaborative text editing
- **Counter CRDT** - For distributed counters
- **Set CRDT** - For collaborative collections

### 2. Advanced Conflict Resolution

Current conflict resolution is primarily timestamp-based (last-write-wins). More
sophisticated strategies could include:

- **Semantic Merging** - Content-aware conflict resolution
- **Three-Way Merging** - Using common ancestor for better resolution
- **User-Assisted Resolution** - Prompting users to resolve conflicts
- **Operation-Based Merging** - Merging operations instead of states

### 3. Snapshots and Pruning

As event logs grow, performance could be improved with:

- **Event Log Pruning** - Removing old events after a certain age
- **Periodic Snapshots** - Creating point-in-time representations of state
- **Incremental Snapshots** - Capturing only changes since the last snapshot
- **Compaction** - Combining multiple events into a single state-change event

### 4. Multi-User Collaboration

The system has a foundation for multi-user access, but could be enhanced for
real-time collaboration:

- **Presence Indicators** - Showing which users are currently active
- **Operational Transformation** - For real-time collaborative editing
- **Change Annotations** - Tracking which user made which changes
- **Access Control** - More granular permissions system

### 5. Offline-First Improvements

While the system supports offline operation, enhancements could include:

- **Conflict Visualization** - Showing users when conflicts have occurred
- **Change Tracking** - Indicating which changes are not yet synced
- **Background Sync** - Synchronizing when the app is in the background
- **Partial Sync** - Syncing only specific subsets of data

## Technical Improvements

### 1. Database Optimizations

```dart
// TODO: test
```

Several areas need more thorough testing and optimization:

- **Query Performance** - Optimizing complex SQL queries
- **Index Tuning** - Adding indexes for common query patterns
- **Bulk Operations** - More efficient batch processing
- **Connection Pooling** - For server-side database connections

### 2. Enhanced Authentication

The current authentication system is basic:

```dart
Future<bool> verifyUser(String userId, String token) async {
  final user = await (select(authTable)
        ..where((t) => t.userId.equals(userId) & t.token.equals(token)))
      .getSingleOrNull();
  return user != null;
}
```

Future improvements could include:

- **JWT Authentication** - More standard token-based auth
- **OAuth Integration** - Supporting third-party authentication
- **Refresh Tokens** - For longer sessions with security
- **Role-Based Access Control** - For more granular permissions

### 3. API Enhancements

The current API could be enhanced with:

- **GraphQL Interface** - For more flexible querying
- **WebSocket Support** - For real-time updates
- **Pagination** - For large result sets
- **Compression** - For more efficient data transfer
- **Rate Limiting** - To prevent abuse

### 4. Monitoring and Analytics

The system doesn't currently have extensive monitoring capabilities. Future
additions could include:

- **Event Metrics** - Tracking event volumes and patterns
- **Sync Performance** - Measuring sync times and volumes
- **Error Tracking** - More sophisticated error handling and reporting
- **Audit Logging** - Detailed trails of system usage

## Platform Enhancements

### 1. Web Support

The system is currently focused on mobile and server, but could be enhanced for
web:

- **IndexedDB Adaptor** - For client-side storage in browsers
- **PWA Support** - For offline-capable web applications
- **Web Worker Integration** - For non-blocking operations

### 2. Reactive UI Integration

Tighter integration with reactive UI frameworks:

- **Flutter** - Better provider/riverpod integration
- **Stream-Based APIs** - More reactive interfaces
- **Change Notifications** - Granular updates for UI components

## Documentation and Tooling

### 1. Developer Tools

- **Admin Interface** - For viewing and managing data
- **Event Visualizer** - For debugging event flows
- **Sync Monitor** - For tracking synchronization status
- **Migration Tools** - For easier schema updates

### 2. Example Applications

- **Collaborative Note-Taking** - Demonstrating text collaboration
- **Task Management** - Showing list management
- **Shared Calendar** - Illustrating time-based collaboration
- **Chat Application** - Demonstrating real-time messaging

## Next Steps from TODOs

Based on the TODOs in the codebase, immediate next steps could include:

1. Implement persistence for HLC state
2. Create a relationship between events and bundles
3. Enhance server timestamp handling
4. Add more comprehensive tests
5. Implement advanced conflict resolution strategies
6. Develop snapshots and pruning mechanisms

## Long-Term Vision

The long-term vision for this system could be:

1. **Full CRDT Library** - A comprehensive library of CRDT data structures
2. **Framework Integration** - Seamless integration with Flutter and other
   frameworks
3. **Enterprise Features** - Security, monitoring, and management for
   large-scale use
4. **Cloud Service** - Managed sync service for easy adoption
5. **Cross-Platform Support** - Web, mobile, desktop clients

## Roadmap

A potential roadmap could be:

### Version 1.1

- Complete all current TODOs
- Add comprehensive test coverage
- Enhance documentation

### Version 1.2

- Implement basic CRDT data structures
- Add snapshots and pruning
- Improve authentication

### Version 1.3

- Add monitoring and analytics
- Enhance synchronization protocol
- Implement more advanced conflict resolution

### Version 2.0

- Full collaborative features
- Web platform support
- Developer tools and admin interface
