import 'package:backend/client_database.dart';
import 'package:backend/messaging.dart';
import 'package:backend/client_definitions.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

void main() {
  late ClientDatabase db;
  final databaseConfig = ClientDatabaseConfig(
    clientId: "clientId",
    userId: "user1",
    userToken: "user1token",
  );

  setUp(() async {
    HLC.reset();
    db = ClientDatabase(
      initialConfig: databaseConfig,
      executor: DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
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
      null,
      events,
    );

    expect(postQuery.toJson(), equals(expectedQuery.toJson()));
  });
}
