import 'package:backend/client_library.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

// AI GENERATED

void main() async {
  final maxEvents = 3000;
  final interval = 100;

  print('N,InsertTime,ReductionTime,CleanAndInsertTime,ReductionFromClean');

  final databaseConfig = ClientDatabaseConfig(
    clientId: "client1",
    userId: "user1",
    userToken: "user1token",
  );

  final db = ClientDatabase(
    initialConfig: databaseConfig,
    executor: DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
  await db.initializeWebMessageChannel();

  final stopwatch = Stopwatch()..start();

  for (var i = 1; i <= maxEvents; i++) {
    // Create document node events using the helper function
    final events = createDocumentNode(
      author: "author$i",
      title: "title$i",
    );

    // Time insertion if it's at an interval point
    if (i % interval == 0) {
      stopwatch.reset();

      // Insert all events
      for (final event in events) {
        await db.clientDrift.insertLocalEventWithClientId(event);
        await db.clientDrift.insertEventIntoAttributes(event);
      }
      final insertTime = stopwatch.elapsedMilliseconds;

      // Time reduction
      stopwatch.reset();
      final nodes = await db.clientDrift.attributesDrift
          .getAttributes()
          .get()
          .then((attrs) => DocumentNodeObj.fromAllAttributes(attrs));
      final reduceTime = stopwatch.elapsedMilliseconds;

      // Time clean and reduce from events
      stopwatch.reset();
      await db.clientDrift.attributesDrift.cleanAttributesTable();
      await db.clientDrift.attributesDrift.insertAllEventsIntoAttributes();
      final cleanAndInsert = stopwatch.elapsedMilliseconds;

      stopwatch.reset();
      final nodesFromClean = await db.clientDrift.attributesDrift
          .getAttributes()
          .get()
          .then((attrs) => DocumentNodeObj.fromAllAttributes(attrs));
      final reduceFromCleanTime = stopwatch.elapsedMilliseconds;

      print('$i, $insertTime, $reduceTime, $cleanAndInsert,'
          ' $reduceFromCleanTime');
    } else {
      // Just insert without timing
      for (final event in events) {
        await db.clientDrift.insertLocalEventWithClientId(event);
        await db.clientDrift.insertEventIntoAttributes(event);
      }
    }
  }

  await db.close();
}
