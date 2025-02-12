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
    await db.serverDrift.sharedUsersDrift
        .createClient(userId: "user1", clientId: "client1");
    await db.serverDrift.usersDrift
        .authUser(userId: "user1", token: "user1token");

    final query = PostQuery("user1token", "user1", "2024-01-30T12:00:00Z", [
      Event(
        id: "event1",
        type: EventTypes.create,
        clientId: "client1",
        clientTimeStamp: "2024-01-30T11:55:00Z",
        serverTimeStamp: null,
        content: EventContent(
          "wow",
          "user1",
          NodeTypes.document,
          NodeContent("author", "title", ["list1"]),
        ),
      )
    ]);

    final a = await db.interpretIncomingPostQueryAndRespond(query);
    print(jsonEncode(a.toJson()));
  });
}

// event -> eventContent -> nodeContent
// node -> nodeContent

// event1 create event2 edit event3 delete ==> nodes
