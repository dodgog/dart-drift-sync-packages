import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  late ClientDatabase db;
  late Map<String, String> config;

  setUp(() async {
    db = ClientDatabase(
        executor: DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ));

    config = {
      "userToken": "user1token",
      "clientId": "client1",
      "userId": "user1"
    };

    await db.clientDrift.usersDrift
        .setUserToken(newUserToken: config["userToken"]);
    await db.clientDrift.usersDrift
        .setClientId(newClientId: config["clientId"]);
    await db.clientDrift.usersDrift.setUserId(newUserId: config["userId"]);
  });
  tearDown(() async {
    await db.close();
  });


  test('reduce create event then edit then delete', () async {
    final eventList = [
      Event(
        id: "event1",
        type: EventTypes.create,
        clientId: "client1",
        targetNodeId: "node1",
        clientTimeStamp: "2024-01-30T11:55:00.000Z",
        serverTimeStamp: null,
        content: EventContent(
          "wow",
          "user1",
          NodeTypes.document,
          NodeContent.document("author", "title"),
        ),
      ),
      Event(
        id: "event2",
        type: EventTypes.edit,
        clientId: "client1",
        targetNodeId: "node1",
        clientTimeStamp: "2025-01-30T11:55:00.000Z",
        serverTimeStamp: null,
        content: EventContent(
          "wowsers",
          "user1",
          NodeTypes.document,
          NodeContent.document("newAuthor", "newTitle"),
        ),
      ),
      Event(
        id: "event3",
        type: EventTypes.delete,
        clientId: "client1",
        targetNodeId: "node1",
        clientTimeStamp: "2026-01-30T11:55:00.000Z",
        serverTimeStamp: null,
        content: null,
      )
    ];

    await db.clientDrift.eventsDrift.insertLocalEventListTransaction(eventList);

    final eventsFromStore =
        await db.clientDrift.sharedEventsDrift.getEvents().get();

    await db.clientDrift.sharedNodesDrift.applyListOfEventsTransaction(eventsFromStore);

    final nodes = await db.clientDrift.sharedNodesDrift.getAllNodes().get();

    print("resulting node ${nodes.first.toJsonString()}");
    expect(nodes.first.content.title,
        equals(eventList[1].content?.nodeContent.title));
    expect(nodes.first.isDeleted, equals(true));
  });
}
