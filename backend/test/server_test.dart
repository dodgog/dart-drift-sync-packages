import 'package:backend/src/server/database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  late ServerDatabase db;
  setUp(() {
    db = ServerDatabase(executor: DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ));
  });
  tearDown(() async {
    await db.close();
  });

  test("document", () async {
    db.serverDrift.usersDrift.sharedUsersDrift.createClient(userId: "user1",
        clientId: "client1");
    db.serverDrift.usersDrift.createUser(userId:  "user1", name: "user1name");
    db.serverDrift.usersDrift.authUser(userId:  "user1", token: "user1token");
    final incoming = """
      {
        "token": "user1token",
        "user_id": "user1",
        "last_issued_server_timestamp": "2024-01-30T12:00:00Z",
        "events": [
          {
            "id": "event1",
            "type": "create",
            "client_id": "client1",
            "client_time_stamp": "2024-01-30T11:55:00Z",
            "server_time_stamp": null,
            "content": "BOOM" 
          }
        ]
      }""";
    final a = await db.interpretIncomingJsonAndRespond(incoming);
    print(a);
  });
}
