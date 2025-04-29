import 'dart:convert';

import 'package:backend/client_xd.dart';
import 'package:backend/server_xd.dart';
import 'package:backend/shared_xd.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:test/test.dart';
import 'package:uuidv7/uuidv7.dart';

import '../server_test_executor.dart';

void runAllServerTests(ServerTestExecutor serverTestExecutor) {
  late ServerDatabase db;

  setUp(() async {
    HLC.reset();
    db = serverTestExecutor.createDatabase(
        initialConfig: ServerDatabaseConfig());
  });

  tearDown(() async {
    await serverTestExecutor.clearDatabaseAndClose(db);
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
    await db.serverDrift.sharedDrift.sharedUsersDrift.createClient(
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

      final query = formQueryFromEvents(createEvents);

      await db.interpretIncomingAuthedPostBundlesQueryAndRespond(query);

      final bundles = await db.serverDrift.bundlesDrift
          .getAllUserBundles(userId: "user1")
          .get();
      final storedEvents = bundles
          .expand((e) => EventPayload.fromJson(jsonDecode(e.payload!)).events);
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
      final query = formQueryFromEvents(allEvents);

      await db.interpretIncomingAuthedPostBundlesQueryAndRespond(query);

      final bundles = await db.serverDrift.bundlesDrift
          .getAllUserBundles(userId: "user1")
          .get();
      final storedEvents = bundles
          .expand((e) => EventPayload.fromJson(jsonDecode(e.payload!)).events);

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

      final query = formQueryFromEvents(shuffledEvents);
      await db.interpretIncomingAuthedPostBundlesQueryAndRespond(query);

      final bundles = await db.serverDrift.bundlesDrift
          .getAllUserBundles(userId: "user1")
          .get();
      final storedEvents = bundles
          .expand((e) => EventPayload.fromJson(jsonDecode(e.payload!)).events);

      // final storedEvents =
      //     await db.serverDrift.sharedDrift.sharedEventsDrift.getEvents().get();
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

      final query = formQueryFromEvents([]);

      final response =
          await db.interpretIncomingAuthedPostBundlesQueryAndRespond(query);

      // Verify response
      expect(response.insertedBundleIds.length, 1);
      expect(response.insertedBundleIds.first, query.bundles.first.id);
      expect(response.newBundles, isEmpty);
      expect(response.lastIssuedServerTimestamp, isNotNull);
    });

    test('query with only timestamp on empty server', () async {
      await setupTestUser();

      final timestamp =
          "${DateTime.now().toUtc().toIso8601String()}-0000-clientId";
      final query =
          formQueryFromEvents([], lastServerIssuedTimeStamp: timestamp);

      final response =
          await db.interpretIncomingAuthedPostBundlesQueryAndRespond(query);

      // Verify response
      expect(response.newBundles, isEmpty);
      expect(response.insertedBundleIds.length, 1);
      expect(response.insertedBundleIds.first, query.bundles.first.id);
      expect(response.lastIssuedServerTimestamp, isNotNull);
      expect(response.lastIssuedServerTimestamp.compareTo(timestamp),
          greaterThan(0));
    });
  });
}

PostBundlesQuery formQueryFromEvents(List<Event> events,
    {String? lastServerIssuedTimeStamp}) {
  return PostBundlesQuery(
    "user1token",
    "user1",
    "${DateTime.now().toUtc().toIso8601String()}-0000-clientId",
    lastServerIssuedTimeStamp ??
        "${DateTime.fromMillisecondsSinceEpoch(0).toUtc().toIso8601String()}-0000-serverId",
    [
      Bundle(
        id: generateUuidV7String(),
        userId: "user1",
        timestamp: "${DateTime.now().toUtc().toIso8601String()}-0000-clientId",
        payload: jsonEncode(EventPayload(events: events)),
      )
    ],
  );
}
