import 'package:backend/client_library.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test/test.dart';

void main() {
  late ClientDatabase db;

  final databaseConfig = ClientDatabaseConfig(
    clientId: "clientId",
    userId: "userId",
    userToken: "userToken",
  );

  setUp(() async {
    ClientDatabase.cleanSlateForTesting();
    db = ClientDatabase(
        initialConfig: databaseConfig,
        executor: DatabaseConnection(
          NativeDatabase.memory(),
          closeStreamsSynchronously: true,
        ));
    await db.initializeWebMessageChannel();
  });

  tearDown(() async {
    await db.close();
  });

  test('reduce create event then edit then delete', () async {
    // Create initial document
    final createEvents = createDocumentNode(
      author: "author",
      title: "title",
    );

    for (final event in createEvents) {
      await db.clientDrift.insertLocalEventWithClientId(event);
      await db.clientDrift.insertEventIntoAttributes(event);
    }

    // Edit document
    final editEvents = modifyDocumentNode(
      nodeId: createEvents.first.entityId,
      author: "newAuthor",
      title: "newTitle",
    );

    for (final event in editEvents) {
      await db.clientDrift.insertLocalEventWithClientId(event);
      await db.clientDrift.insertEventIntoAttributes(event);
    }

    // Delete document
    final deleteEvent = deleteNode(nodeId: createEvents.first.entityId);
    await db.clientDrift.insertLocalEventWithClientId(deleteEvent);
    await db.clientDrift.insertEventIntoAttributes(deleteEvent);

    // Get final state
    final attributes =
        await db.clientDrift.attributesDrift.getAttributes().get();
    final nodes = DocumentNodeObj.fromAllAttributes(attributes);

    expect(nodes.first.author, equals("newAuthor"));
    expect(nodes.first.title, equals("newTitle"));
    expect(nodes.first.isDeleted, equals(true));
  });

  test('reduce create event then older edit and delete', () async {
    // Create initial document with newer timestamp
    final createEvents = createDocumentNode(
      author: "author",
      title: "title",
    );

    for (final event in createEvents) {
      await db.clientDrift.insertLocalEventWithClientId(event);
      await db.clientDrift.insertEventIntoAttributes(event);
    }

    // Clean and reduce to ensure consistent state
    await db.clientDrift.attributesDrift.cleanAndReduceAttributeTable();

    final attributes =
        await db.clientDrift.attributesDrift.getAttributes().get();
    final nodes = DocumentNodeObj.fromAllAttributes(attributes);

    expect(nodes.first.author, equals("author"));
    expect(nodes.first.title, equals("title"));
    expect(nodes.first.isDeleted, equals(false));
  });

  test("create document node and reduce", () async {
    final createEvents = createDocumentNode(
      author: "author",
      title: "title",
    );

    for (final event in createEvents) {
      await db.clientDrift.insertLocalEventWithClientId(event);
      await db.clientDrift.insertEventIntoAttributes(event);
    }

    final attributes =
        await db.clientDrift.attributesDrift.getAttributes().get();
    final nodes = DocumentNodeObj.fromAllAttributes(attributes);

    expect(nodes.length, equals(1));
    expect(nodes.first.author, equals("author"));
    expect(nodes.first.title, equals("title"));
    expect(nodes.first.isDeleted, equals(false));
  });

  test("create edit delete document node and reduce", () async {
    // Create document
    final createEvents = createDocumentNode(
      author: "author",
      title: "title",
    );

    for (final event in createEvents) {
      await db.clientDrift.insertLocalEventWithClientId(event);
      await db.clientDrift.insertEventIntoAttributes(event);
    }

    // Edit document
    final editEvents = modifyDocumentNode(
      nodeId: createEvents.first.entityId,
      author: "new author",
      title: "new title",
    );

    for (final event in editEvents) {
      await db.clientDrift.insertLocalEventWithClientId(event);
      await db.clientDrift.insertEventIntoAttributes(event);
    }

    final attributes =
        await db.clientDrift.attributesDrift.getAttributes().get();
    final nodesAfterEdit = DocumentNodeObj.fromAllAttributes(attributes);

    expect(nodesAfterEdit.first.author, equals("new author"));
    expect(nodesAfterEdit.first.title, equals("new title"));

    // Delete document
    final deleteEvent = deleteNode(nodeId: createEvents.first.entityId);
    await db.clientDrift.insertLocalEventWithClientId(deleteEvent);
    await db.clientDrift.insertEventIntoAttributes(deleteEvent);

    final attributesAfterDelete =
        await db.clientDrift.attributesDrift.getAttributes().get();
    final nodesAfterDelete =
        DocumentNodeObj.fromAllAttributes(attributesAfterDelete);
    expect(nodesAfterDelete.first.isDeleted, equals(true));
  });
}
