import 'dart:convert';

import 'package:backend/client_library.dart';
import 'package:backend/core_data_library.dart';
import 'package:backend/messaging.dart';
import 'package:backend/shared_library.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:test/test.dart';
import 'package:uuidv7/uuidv7.dart';

// This function creates a SyncService for tests
SyncService createSyncService(ClientDatabase db) {
  return SyncService(db);
}

void main() {
  late ClientDatabase db;
  late SyncService syncService;
  final databaseConfig = CoreDataClientConfig(
    clientId: "clientId",
    userId: "user1",
    userToken: "user1token",
  );

  setUp(() async {
    ClientDatabase.cleanSlateForTesting();

    db = ClientDatabase(
      initialConfig: databaseConfig,
      executor: DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );

    // Create a sync service for testing using the extension method
    syncService = db.createSyncService();

    await db.initializeWebMessageChannel();
  });

  tearDown(() async {
    await db.close();
  });

  test('push event', () async {
    // Create a document node using helper function
    final events = createDocumentNode(
      author: "author",
      title: "title",
    );

    // Insert the events
    for (final event in events) {
      await db.clientDrift.insertLocalEventWithClientId(event);
    }

    // Use sync service to push events instead of calling directly on db
    final postQuery = await syncService.pushEvents();

    // Create expected query
    final expectedQuery = PostBundlesQuery(
        "user1token",
        "user1",
        HLC().sendPacked(),
        "${DateTime.fromMillisecondsSinceEpoch(0).toUtc().toIso8601String()}-0000-serverId",
        [
          Bundle(
            id: generateUuidV7String(),
            userId: "user1",
            timestamp:
                "${DateTime.now().toUtc().toIso8601String()}-0000-clientId",
            payload: jsonEncode(EventPayload(events: events)),
          )
        ]);

    expect(postQuery.userId, equals(expectedQuery.userId));
    expect(postQuery.bundles.length, equals(expectedQuery.bundles.length));
    expect(postQuery.bundles.first.userId,
        equals(expectedQuery.bundles.first.userId));

    final decodedEvents = postQuery.bundles
        .map((e) => e.payload)
        .expand((e) => EventPayload.fromJson(jsonDecode(e!)).events);
    expect(decodedEvents,
        equals(events.map((e) => e.copyWith(clientId: "clientId"))));
  });
}
