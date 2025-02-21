import 'package:backend/client_database.dart';
import 'package:backend/messaging.dart';
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

    await db.clientDrift.usersDrift.setUserToken(newUserToken: "user1toke"
        "n");
    await db.clientDrift.usersDrift.setClientId(newClientId: "client1");
    await db.clientDrift.usersDrift.setUserId(newUserId: "user1");
    await db.clientDrift.sharedUsersDrift.createClient(
        clientId: "client1",
        userId: "user1"
    );

    final client = await db.clientDrift.usersDrift.getCurrentClient()
        .getSingle();
  });
  tearDown(() async {
    await db.close();
  });

  test('push event', () async {
    final event = Event(
      id: "event1",
      type: EventTypes.create,
      clientId: "client1",
      targetNodeId: 'targetNode',
      timestamp: "2024-01-30T11:55:00.000Z-0000-clientId",
      content: EventContent(
        "wow",
        "user1",
        EventTypes.create,
        NodeTypes.document,
        NodeContent.document("author", "title"),
      ),
    );

    await db.clientDrift.eventsDrift.insertLocalEvent(
      id: event.id,
      type: event.type,
      clientId: event.clientId,
      timestamp: event.timestamp,
      content: event.content,
      targetNodeId: 'targetNode',
    );

    final postQuery = await db.pushEvents();

    final query =
        PostQuery("user1token", "user1", null, [event]);
    expect(postQuery.toJson(), equals(query.toJson()));
  });
//
//   test('pull nothing to push', () async {
//     final event = Event(
//       id: "event1",
//       type: EventTypes.create,
//       clientId: "client1",
//       timestamp: "2024-01-30T11:55:00.000Z-0000-clientId",
//       content: EventContent(
//         "wow",
//         "user1",
//         EventTypes.create,
//         NodeTypes.document,
//         NodeContent.document("author", "title"),
//       ),
//     );
//
//     await db.clientDrift.eventsDrift.insertLocalEvent(
//       id: event.id,
//       type: event.type,
//       clientId: event.clientId,
//       timestamp: event.timestamp,
//       content: event.content,
//       targetNodeId: 'targetNode',
//     );
//
//     final serverIssuedTime = DateTime.now().toIso8601String();
//
//     await db.pullEvents(PostResponse(serverIssuedTime, [event]));
//
//     final postQuery = await db.pushEvents();
//
//     print(await db.events.select().get());
//
//     expect(
//         postQuery.toJson(),
//         equals(PostQuery(
//                 config["userToken"]!, config["userId"]!, serverIssuedTime,
//             [])
//             .toJson()));
//   });
}

//
