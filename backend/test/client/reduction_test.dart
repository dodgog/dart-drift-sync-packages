import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:backend/src/client_definitions/issue_helper.dart';
import 'package:backend/src/client_definitions/client_node_helper.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:test/test.dart';

void main() {
  late ClientDatabase db;
  late Map<String, String> config;
  late Client client;

  setUp(() async {
    HLC.reset();
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

    await db.clientDrift.usersDrift.setUserToken(newUserToken: "user1toke"
        "n");
    await db.clientDrift.usersDrift.setClientId(newClientId: "client1");
    await db.clientDrift.usersDrift.setUserId(newUserId: "user1");
    await db.clientDrift.sharedUsersDrift.createClient(
        clientId: "client1",
        userId: "user1"
    );

    client = await db.clientDrift.usersDrift.getCurrentClient()
        .getSingle();
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
        timestamp: "2024-01-30T11:55:00.000Z-0000-clientId",
        content: EventContent(
          "wow",
          "user1",
          EventTypes.create,
          NodeTypes.document,
          NodeContent.document("author", "title"),
        ),
      ),
      Event(
        id: "event2",
        type: EventTypes.edit,
        clientId: "client1",
        targetNodeId: "node1",
        timestamp: "2024-01-30T11:55:00.001Z-0000-clientId",
        content: EventContent(
          "wowsers",
          "user1",
          EventTypes.edit,
          NodeTypes.document,
          NodeContent.document("newAuthor", "newTitle"),
        ),
      ),
      Event(
        id: "event3",
        type: EventTypes.delete,
        clientId: "client1",
        targetNodeId: "node1",
        timestamp: "2024-01-30T11:55:00.002Z-0000-clientId",
        content: null,
      )
    ];

    await db.clientDrift.insertLocalEventListTEST(eventList);

    final eventsFromStore =
        await db.clientDrift.sharedEventsDrift.getEvents().get();

    await db.clientDrift.sharedNodesDrift.applyListOfEvents(eventsFromStore);

    final nodes = await db.clientDrift.sharedNodesDrift.getAllNodes().get();

    print("resulting node ${nodes.first.toJsonString()}");
    expect(nodes.first.content.title,
        equals(eventList[1].content?.nodeContent.title));
    expect(nodes.first.isDeleted, equals(true));
  });

  test('reduce create event then older edit and delete', () async {
    final eventList = [
      Event(
        id: "event1",
        type: EventTypes.create,
        clientId: "client1",
        targetNodeId: "node1",
        timestamp: "2024-01-30T11:55:00.001Z-0000-clientId",
        content: EventContent(
          "wow",
          "user1",
          EventTypes.create,
          NodeTypes.document,
          NodeContent.document("author", "title"),
        ),
      ),
      Event(
        id: "event2",
        type: EventTypes.edit,
        clientId: "client1",
        targetNodeId: "node1",
        timestamp: "2024-01-30T11:55:00.000Z-0000-clientId",
        content: EventContent(
          "wowsers",
          "user1",
          EventTypes.edit,
          NodeTypes.document,
          NodeContent.document("newAuthor", "newTitle"),
        ),
      ),
      Event(
        id: "event3",
        type: EventTypes.delete,
        clientId: "client1",
        targetNodeId: "node1",
        timestamp: "2024-01-30T11:55:00.000Z-0000-clientId",
        content: null,
      )
    ];

    await db.clientDrift.insertLocalEventListTEST(eventList);

    final eventsFromStore =
    await db.clientDrift.sharedEventsDrift.getEvents().get();

    await db.clientDrift.sharedNodesDrift.applyListOfEvents(eventsFromStore);

    final nodes = await db.clientDrift.sharedNodesDrift.getAllNodes().get();

    print("resulting node ${nodes.first.toJsonString()}");
    expect(nodes.first.content.title,
        equals(eventList[0].content?.nodeContent?.title));
    expect(nodes.first.isDeleted, equals(false));
  });

  test("create node issue and reduce", () async {
    final eventToInsert = issueRawCreateEventFromNode(
      Node(
        id: 'tobeassigned',
        type: NodeTypes.document,
        lastModifiedAtTimestamp : "2024-01-30T11:55:00.000Z-0000-clientId",
        userId: 'user1',
        isDeleted: false,
        content: NodeContent(NodeTypes.document, "author", "title", null),
      ), client,
    );

    await db.clientDrift.insertLocalEventWithClientId
      (eventToInsert);

    final nodes = await db.clientDrift.reduceAllEventsIntoNodes();

    print(nodes.first.toJsonString());
    print(await db.clientDrift.sharedEventsDrift.getEvents().get());
  });

  test("create edit delete node issue and reduce", () async {
    final eventToInsert = issueRawCreateEventFromNode(
      Node(
        id: 'tobeassigned',
        type: NodeTypes.document,
        lastModifiedAtTimestamp : "2024-01-30T11:55:00.000Z-0000-clientId",
        userId: 'user1',
        isDeleted: false,
        content: NodeContent(NodeTypes.document, "author", "title", null),
      ), client
    );

    await db.clientDrift.insertLocalEventWithClientId
      (eventToInsert);

    final nodes = await db.clientDrift.reduceAllEventsIntoNodes();

    print(await db.clientDrift.sharedEventsDrift.getEvents().get());

    final editEvent = nodes.first.issueRawEditEventFromMutatedContent(
      NodeContent(
        NodeTypes.document,
        "new author",
        "new title", null,),client,);
    await db.clientDrift.insertLocalEventWithClientId(editEvent);
    final nodesAfterEdit = await db.clientDrift
        .reduceAllEventsIntoNodes();
    print(nodesAfterEdit.first.toJsonString());

    final deleteEvent = nodesAfterEdit.first.issueRawDeleteNodeEvent(
        client,);
    await db.clientDrift.insertLocalEventWithClientId(deleteEvent);
    final nodesAfterDelete = await db.clientDrift
        .reduceAllEventsIntoNodes();
    print(nodesAfterDelete.first.toJsonString());

  });
}
