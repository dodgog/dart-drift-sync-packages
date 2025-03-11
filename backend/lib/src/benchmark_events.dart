import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

// AI GENERATED

void main() async {
  final maxEvents = 10000;
  final interval = 100;

  print('N,InsertTime,ReductionTime,CleanAndReduceTime');

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

  final client = await db.clientDrift.usersDrift.getCurrentClient().getSingle();

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
        await db.clientDrift.insertLocalEventIntoAttributes(event);
      }
      final insertTime = stopwatch.elapsedMilliseconds;

      // Time reduction
      stopwatch.reset();
      final nodes = await db.clientDrift.sharedDrift.sharedAttributesDrift
          .getAttributes()
          .get()
          .then((attrs) => DocumentNodeObj.fromAllAttributes(attrs));
      final reduceTime = stopwatch.elapsedMilliseconds;

      // Time clean and reduce from events
      stopwatch.reset();
      await db.clientDrift.sharedDrift.sharedAttributesDrift
          .cleanAttributesTable();
      await db.clientDrift.sharedDrift.sharedAttributesDrift
          .insertAllEventsIntoAttributes();
      final cleanAndReduceTime = stopwatch.elapsedMilliseconds;

      print('$i,$insertTime,$reduceTime,$cleanAndReduceTime');
    } else {
      // Just insert without timing
      for (final event in events) {
        await db.clientDrift.insertLocalEventWithClientId(event);
        await db.clientDrift.insertLocalEventIntoAttributes(event);
      }
    }
  }

  await db.close();
}
