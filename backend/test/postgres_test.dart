import 'dart:convert';

import 'package:backend/messaging.dart';
import 'package:backend/server_definitions.dart';
import 'package:backend/src/server_database/database.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

void main() {
  late ServerDatabase db;

  setUp(() async {
    db = ServerDatabase(
        executor: PgDatabase(
      endpoint: Endpoint(
        host: 'localhost',
        database: 'postgres',
        username: 'postgres',
        password: 'postgres',
      ),
      settings: ConnectionSettings(
        sslMode: SslMode.disable,
      ),
    ));
  });

  tearDown(() async {
    await db.customStatement('DROP SCHEMA public CASCADE;');
    await db.customStatement('CREATE SCHEMA public;');
    await db.customStatement('GRANT ALL ON SCHEMA public TO postgres;');
    await db.customStatement('GRANT ALL ON SCHEMA public TO public;');
    await db.close();
  });

  test('interpret event', () async {
    await db.serverDrift.usersDrift
        .createUser(userId: "user1", name: "user1name");
    await db.serverDrift.sharedUsersDrift
        .createClient(userId: "user1", clientId: "client1");
    await db.serverDrift.usersDrift
        .authUser(userId: "user1", token: "user1token");

    final json = PostQuery(
        "user1token",
        "user1",
        "2024-01-30T12:00:00Z",
        [
          Event(
              id: "event1",
              type: 'create',
              clientId: "client1",
              clientTimeStamp: "2024-01-30T11:55:00Z",
              serverTimeStamp: null,
              content: "a")
        ]).toJson();
    final incoming = jsonEncode(json);

    final a = await db.interpretIncomingJsonAndRespond(incoming);
    print(a);
  });
}
