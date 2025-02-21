import 'dart:convert';

import 'package:backend/client_definitions.dart';
import 'package:backend/messaging.dart';
import 'package:test/test.dart';
import 'package:backend/server_database.dart';

import '../server_test_executor.dart';

void runAllServerTests(ServerTestExecutor executor) {
  late ServerDatabase db;

  setUp(() async {
    db = executor.createDatabase();
  });

  tearDown(() async {
    await executor.clearDatabaseAndClose(db);
  });

  test('interpret event', () async {
    await db.serverDrift.usersDrift
        .createUser(userId: "user1", name: "user1name");
    await db.serverDrift.usersDrift
        .authUser(userId: "user1", token: "user1token");

    await db.serverDrift.sharedUsersDrift
        .createClient(userId: "user1", clientId: "client1");

    final query = PostQuery("user1token", "user1", "${DateTime.now().toUtc()
        .toIso8601String()}-0000-clientId", [
      Event(
        id: "event1",
        type: EventTypes.create,
        clientId: "client1",
        timestamp: "${DateTime.now().toUtc().toIso8601String()}-0000-clientId",
        content: EventContent(
          "wow",
          "user1",
          EventTypes.create,
          NodeTypes.document,
          NodeContent.document("author", "title"),
        ),
      )
    ]);

    final a = await db.interpretIncomingPostQueryAndRespond(query);
    print(jsonEncode(a.toJson()));
  });
}
