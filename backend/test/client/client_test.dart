import 'dart:convert';

import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:backend/messaging.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:test/test.dart';
import 'package:uuidv7/uuidv7.dart';

void main() {
  late ClientDatabase db;
  final databaseConfig = ClientDatabaseConfig(
    clientId: "clientId",
    userId: "user1",
    userToken: "user1token",
  );

  setUp(() async {
    HLC.reset();
    // HLC.initialize(clientNode: ClientNode("clientId"));
    db = ClientDatabase(
      initialConfig: databaseConfig,
      executor: DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );

    // TODO: read ensureInitialized todo!!!!!
    await db.ensureInitialized();
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

    // Get events to push
    final postQuery = await db.pushEvents();

    // Create expected query
    final expectedQuery = PostQuery(
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
