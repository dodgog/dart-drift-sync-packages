import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  late ClientDatabase db;
  late String baseTimestamp;

  setUp(() async {
    baseTimestamp = DateTime.now().toIso8601String();

    final databaseConfig = ClientDatabaseConfig(
      clientId: "client1",
      userId: "user1",
      userToken: "user1token",
    );

    db = ClientDatabase(
      initialConfig: databaseConfig,
      executor: DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );

    await db.ensureInitialized();
  });

  tearDown(() async {
    await db.close();
  });

  test('bulk insert from events should respect timestamp ordering', () async {
    final timestamps = {
      'oldest': _getTimestamp(hours: -2),
      'older': _getTimestamp(hours: -1),
      'newest': baseTimestamp,
    };

    await _insertTestEvents(
      db: db,
      events: [
        _createTestEvent(
          id: 'event1',
          value: 'Old Title',
          timestamp: timestamps['older']!,
        ),
        _createTestEvent(
          id: 'event2',
          value: 'New Title',
          timestamp: timestamps['newest']!,
        ),
      ],
    );

    // Insert initial state directly
    await db.clientDrift.attributesDrift.insertEventIntoAttributes(
      entityId: 'node1',
      attribute: 'title',
      value: 'Initial Title',
      timestamp: timestamps['older']!,
    );

    // Act - First bulk insert using helper
    await db.clientDrift.attributesDrift.cleanAndReduceAttributeTable();

    // Assert - Should have newest value
    final newAttribute =
        await db.clientDrift.attributesDrift.getAttributes().getSingle();
    _assertAttribute(
      attribute: newAttribute,
      expectedValue: 'New Title',
      expectedTimestamp: timestamps['newest']!,
    );

    // Arrange - Add older event
    await _insertTestEvents(
      db: db,
      events: [
        _createTestEvent(
          id: 'event3',
          value: 'Very Old Title',
          timestamp: timestamps['oldest']!,
        ),
      ],
    );

    await db.clientDrift.attributesDrift.cleanAndReduceAttributeTable();
    final attribute =
        await db.clientDrift.attributesDrift.getAttributes().getSingle();
    _assertAttribute(
      attribute: attribute,
      expectedValue: 'New Title',
      expectedTimestamp: timestamps['newest']!,
    );
  });
}

String _getTimestamp({required int hours}) {
  return DateTime.now().add(Duration(hours: hours)).toIso8601String();
}

Event _createTestEvent({
  required String id,
  required String value,
  required String timestamp,
}) {
  return Event(
    id: id,
    clientId: 'client1',
    entityId: 'node1',
    attribute: 'title',
    value: value,
    timestamp: timestamp,
  );
}

Future<void> _insertTestEvents({
  required ClientDatabase db,
  required List<Event> events,
}) async {
  for (final event in events) {
    await db.clientDrift.insertLocalEventWithClientId(event);
  }
}

void _assertAttribute({
  required Attribute attribute,
  required String expectedValue,
  required String expectedTimestamp,
}) {
  expect(attribute.value, equals(expectedValue),
      reason: 'Attribute value '
          'should match expected');
  expect(attribute.timestamp, equals(expectedTimestamp),
      reason: 'Attribute timestamp should match expected');
}
