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

    await db.clientDrift.usersDrift
        .setUserToken(newUserToken: config["userToken"]);
    await db.clientDrift.usersDrift
        .setClientId(newClientId: config["clientId"]);
    await db.clientDrift.usersDrift.setUserId(newUserId: config["userId"]);
  });
  tearDown(() async {
    await db.close();
  });

  test('push event', () async {
    final event = Event(
        id: "event1",
        type: EventTypes.create,
        clientId: "client1",
        clientTimeStamp: "2024-01-30T11:55:00.000Z",
        serverTimeStamp: null,
        content: EventContent(true, "Theme 2"));

    await db.clientDrift.eventsDrift.insertLocalEvent(
        id: event.id,
        type: event.type,
        clientId: event.clientId,
        clientTimeStamp: event.clientTimeStamp,
        content: event.content);

    final postQuery = await db.pushEvents();

    final query =
        PostQuery("user1token", "user1", "1969-12-31T16:00:00.000", [event]);
    expect(postQuery.toJson(), equals(query.toJson()));
  });

  test('pull nothing to push', () async {
    final event = Event(
        id: "event1",
        type: EventTypes.create,
        clientId: "client1",
        clientTimeStamp: "2024-01-30T11:55:00.000Z",
        serverTimeStamp: "2025-01-30T11:55:00.000Z",
        content: EventContent(true, "Theme 2"));

    await db.clientDrift.eventsDrift.insertLocalEvent(
        id: event.id,
        type: event.type,
        clientId: event.clientId,
        clientTimeStamp: event.clientTimeStamp,
        content: event.content);

    final serverIssuedTime = DateTime.now().toIso8601String();

    await db.pullEvents(PostResponse(serverIssuedTime, [event]));

    final postQuery = await db.pushEvents();

    print(await db.events.select().get());

    expect(
        postQuery.toJson(),
        equals(PostQuery(
                config["userToken"]!, config["userId"]!, serverIssuedTime, [])
            .toJson()));
  });
}
