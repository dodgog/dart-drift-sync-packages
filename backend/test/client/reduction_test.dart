import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:backend/src/shared_definitions/apply_event_to_node.dart';
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

  test('reduce create event', () async {
    final event = Event(
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
        NodeContent("author", "title", ["list1"]),
      ),
    );

    await db.clientDrift.eventsDrift.insertLocalEvent(
        id: event.id,
        type: event.type,
        targetNodeId: event.targetNodeId,
        clientId: event.clientId,
        clientTimeStamp: event.clientTimeStamp,
        content: event.content);

    final events = await db.clientDrift.sharedEventsDrift.getEvents().get();
    await db.clientDrift.sharedNodesDrift.applyEvent(events.first);

    final nodes = await db.clientDrift.sharedNodesDrift.getAllNodes().get();
    print(nodes.first);
  });

  test('reduce create event then delete', () async {
    final event1 = Event(
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
        NodeContent("author", "title", ["list1"]),
      ),
    );

    final event2 = Event(
      id: "event2",
      type: EventTypes.delete,
      clientId: "client1",
      targetNodeId: "node1",
      clientTimeStamp: "2025-01-30T11:55:00.000Z",
      serverTimeStamp: null,
      content: null,
    );

    await db.clientDrift.eventsDrift.insertLocalEvent(
        id: event1.id,
        type: event1.type,
        targetNodeId: event1.targetNodeId,
        clientId: event1.clientId,
        clientTimeStamp: event1.clientTimeStamp,
        content: event1.content);

    await db.clientDrift.eventsDrift.insertLocalEvent(
        id: event2.id,
        type: event2.type,
        targetNodeId: event2.targetNodeId,
        clientId: event2.clientId,
        clientTimeStamp: event2.clientTimeStamp,
        content: event2.content);

    final events = await db.clientDrift.sharedEventsDrift.getEvents().get();
    for (final event in events) {
      await db.clientDrift.sharedNodesDrift.applyEvent(event);
    }

    final nodes = await db.clientDrift.sharedNodesDrift.getAllNodes().get();
    print(nodes.first);
  });

  test('reduce create event then edit', () async {
    final event1 = Event(
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
        NodeContent("author", "title", ["list1"]),
      ),
    );

    final event2 = Event(
      id: "event2",
      type: EventTypes.edit,
      clientId: "client1",
      targetNodeId: "node1",
      clientTimeStamp: "2025-01-30T11:55:00.000Z",
      serverTimeStamp: null,
      content: EventContent(
        "wow",
        "user1",
        NodeTypes.document,
        NodeContent("newAuthor", "newTitle", ["list1"]),
      ),
    );

    await db.clientDrift.eventsDrift.insertLocalEvent(
        id: event1.id,
        type: event1.type,
        targetNodeId: event1.targetNodeId,
        clientId: event1.clientId,
        clientTimeStamp: event1.clientTimeStamp,
        content: event1.content);

    await db.clientDrift.eventsDrift.insertLocalEvent(
        id: event2.id,
        type: event2.type,
        targetNodeId: event2.targetNodeId,
        clientId: event2.clientId,
        clientTimeStamp: event2.clientTimeStamp,
        content: event2.content);

    final events = await db.clientDrift.sharedEventsDrift.getEvents().get();
    for (final event in events) {
      await db.clientDrift.sharedNodesDrift.applyEvent(event);
      print("applying event ${event.toJsonString()}");
    }

    final nodes = await db.clientDrift.sharedNodesDrift.getAllNodes().get();
    print("resulting node ${nodes.first.toJsonString()}");
    expect(
        nodes.first.content.title, equals(event2.content?.nodeContent.title));
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
          NodeContent("author", "title", ["list1"]),
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
          NodeContent("newAuthor", "newTitle", ["list1, list2"]),
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

    for (final eventObj in eventList) {
      await db.clientDrift.eventsDrift.insertLocalEvent(
          id: eventObj.id,
          type: eventObj.type,
          targetNodeId: eventObj.targetNodeId,
          clientId: eventObj.clientId,
          clientTimeStamp: eventObj.clientTimeStamp,
          content: eventObj.content);
    }

    final eventsFromStore =
        await db.clientDrift.sharedEventsDrift.getEvents().get();
    for (final eventFromStore in eventsFromStore) {
      await db.clientDrift.sharedNodesDrift.applyEvent(eventFromStore);
      print("applying event ${eventFromStore.toJsonString()}");
    }

    final nodes = await db.clientDrift.sharedNodesDrift.getAllNodes().get();
    print("resulting node ${nodes.first.toJsonString()}");
    expect(nodes.first.content.title,
        equals(eventList[1].content?.nodeContent.title));
    expect(nodes.first.isDeleted, equals(true));
  });
}
