import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';
import 'package:backend/client_library.dart';

void main() {
  late ClientDatabase db;

  setUp(() async {
    final databaseConfig = ClientDatabaseConfig(
      clientId: "client1",
      userId: "user1",
      userToken: "user1token",
    );

    ClientDatabase.cleanSlateForTesting();

    db = ClientDatabase(
      initialConfig: databaseConfig,
      executor: DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );

    await db.initializeWebMessageChannel();
  });

  tearDown(() async {
    await db.close();
  });

  test('attribute conflicts should keep newer timestamp value', () async {
    // Create two events for the same entity and attribute with different timestamps
    final olderTimestamp =
        DateTime.now().subtract(Duration(hours: 1)).toIso8601String();
    final newerTimestamp = DateTime.now().toIso8601String();

    // Insert older event first
    await db.clientDrift.attributesDrift.insertEventIntoAttributes(
      entityId: 'node1',
      attribute: 'title',
      value: 'Old Title',
      timestamp: olderTimestamp,
    );

    // Insert newer event
    await db.clientDrift.attributesDrift.insertEventIntoAttributes(
      entityId: 'node1',
      attribute: 'title',
      value: 'New Title',
      timestamp: newerTimestamp,
    );

    // Get the attribute and verify it has the newer value
    final attributes =
        await db.clientDrift.attributesDrift.getAttributes().get();

    expect(attributes.length, equals(1));
    expect(attributes.first.value, equals('New Title'));
    expect(attributes.first.timestamp, equals(newerTimestamp));

    // Try inserting older event again - should not override newer value
    await db.clientDrift.attributesDrift.insertEventIntoAttributes(
      entityId: 'node1',
      attribute: 'title',
      value: 'Old Title',
      timestamp: olderTimestamp,
    );

    final attributesAfterOldInsert =
        await db.clientDrift.attributesDrift.getAttributes().get();

    expect(attributesAfterOldInsert.length, equals(1));
    expect(attributesAfterOldInsert.first.value, equals('New Title'));
    expect(attributesAfterOldInsert.first.timestamp, equals(newerTimestamp));
  });
}
