import 'package:backend/client_definitions.dart';
import 'package:backend/messaging.dart';
import 'package:backend/server_database.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:test/test.dart';

import '../server_test_executor.dart';

void runAllServerTests(ServerTestExecutor executor) {
  late ServerDatabase db;

  setUp(() async {
    HLC.reset();
    db = executor.createDatabase(initialConfig: ServerDatabaseConfig());
  });

  tearDown(() async {
    await executor.clearDatabaseAndClose(db);
  });

  Future<void> setupTestUser() async {
    const userId = "user1";
    await db.serverDrift.usersDrift.createUser(
      userId: userId,
      name: "${userId}name",
    );
    await db.serverDrift.usersDrift.authUser(
      userId: userId,
      token: "${userId}token",
    );
    await db.serverDrift.sharedUsersDrift.createClient(
      userId: userId,
      clientId: "client1",
    );
  }

  group('Document operations', () {
    test('create document', () async {
      await setupTestUser();

      final createEvents = createDocumentNode(
        author: "author1",
        title: "title1",
      );

      final query = PostQuery(
        "user1token",
        "user1",
        "${DateTime.now().toUtc().toIso8601String()}-0000-clientId",
        null,
        createEvents,
      );

      await db.interpretIncomingPostQueryAndRespond(query);

      final storedEvents =
          await db.serverDrift.sharedEventsDrift.getEvents().get();
      expect(storedEvents.length, equals(createEvents.length));
    });

    test('modify document', () async {
      await setupTestUser();

      final createEvents = createDocumentNode(
        author: "author1",
        title: "title1",
      );

      final modifyEvents = modifyDocumentNode(
        nodeId: createEvents.first.entityId,
        author: "author2",
        title: "title2",
      );

      final allEvents = [...createEvents, ...modifyEvents];
      final query = PostQuery(
        "user1token",
        "user1",
        "${DateTime.now().toUtc().toIso8601String()}-0000-clientId",
        null,
        allEvents,
      );

      await db.interpretIncomingPostQueryAndRespond(query);

      final storedEvents =
          await db.serverDrift.sharedEventsDrift.getEvents().get();
      expect(storedEvents.length, equals(allEvents.length));

      final modificationEvents = storedEvents
          .where((e) =>
              e.entityId == createEvents.first.entityId &&
              (e.attribute == 'author' || e.attribute == 'title') &&
              (e.value == 'author2' || e.value == 'title2'))
          .toList();

      final authorModifications =
          modificationEvents.where((e) => e.attribute == 'author').toList();
      final titleModifications =
          modificationEvents.where((e) => e.attribute == 'title').toList();

      expect(modificationEvents.length, equals(2));
      expect(authorModifications.length, equals(1));
      expect(titleModifications.length, equals(1));
      expect(authorModifications.first.value, equals('author2'));
      expect(titleModifications.first.value, equals('title2'));
    });

    test('events order does not matter', () async {
      await setupTestUser();

      final createEvents = createDocumentNode(
        author: "author1",
        title: "title1",
      );

      final modifyEvents = modifyDocumentNode(
        nodeId: createEvents.first.entityId,
        author: "author2",
        title: "title2",
      );

      final allEvents = [...createEvents, ...modifyEvents];
      // Create a shuffled copy of the events
      final shuffledEvents = List<Event>.from(allEvents)..shuffle();

      final query = PostQuery(
        "user1token",
        "user1",
        "${DateTime.now().toUtc().toIso8601String()}-0000-clientId",
        null,
        shuffledEvents,
      );

      await db.interpretIncomingPostQueryAndRespond(query);

      final storedEvents =
          await db.serverDrift.sharedEventsDrift.getEvents().get();
      expect(storedEvents.length, equals(allEvents.length));

      // Verify final state is the same regardless of event order
      final modificationEvents = storedEvents
          .where((e) =>
              e.entityId == createEvents.first.entityId &&
              (e.attribute == 'author' || e.attribute == 'title') &&
              (e.value == 'author2' || e.value == 'title2'))
          .toList();

      expect(modificationEvents.length, equals(2));
      expect(
        modificationEvents.where((e) => e.attribute == 'author').single.value,
        equals('author2'),
      );
      expect(
        modificationEvents.where((e) => e.attribute == 'title').single.value,
        equals('title2'),
      );
    });

    test('empty events list in query', () async {
      await setupTestUser();

      final query = PostQuery(
        "user1token",
        "user1",
        "${DateTime.now().toUtc().toIso8601String()}-0000-clientId",
        null,
        [], // Empty events list
      );

      final response = await db.interpretIncomingPostQueryAndRespond(query);

      // Verify response
      expect(response.events, isEmpty);
      expect(response.lastIssuedServerTimestamp, isNotNull);
    });

    test('query with only timestamp on empty server', () async {
      await setupTestUser();

      final timestamp =
          "${DateTime.now().toUtc().toIso8601String()}-0000-clientId";
      final query = PostQuery(
        "user1token",
        "user1",
        timestamp,
        null,
        [], // Empty events list
      );

      final response = await db.interpretIncomingPostQueryAndRespond(query);

      // Verify response
      expect(response.events, isEmpty);
      expect(response.lastIssuedServerTimestamp, isNotNull);
      expect(response.lastIssuedServerTimestamp.compareTo(timestamp),
          greaterThan(0));
    });
  });
}
