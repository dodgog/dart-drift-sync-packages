import 'package:backend/client_database.dart';
import 'package:backend/client_definitions.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

// AI GENERATED

void main() async {
  final maxEvents = 100;
  final interval = 100;

  print('N,InsertTime,ReductionTime');

  final db = ClientDatabase(
      executor: DatabaseConnection(
    NativeDatabase.memory(),
    closeStreamsSynchronously: true,
  ));

  await db.clientDrift.usersDrift.setUserToken(newUserToken: "user1toke"
      "n");
  await db.clientDrift.usersDrift.setClientId(newClientId: "client1");
  await db.clientDrift.usersDrift.setUserId(newUserId: "user1");
  await db.clientDrift.sharedUsersDrift.createClient(
      clientId: "client1",
      userId: "user1"
  );

  final client = await db.clientDrift.usersDrift.getCurrentClient()
      .getSingle();

  HLC.initialize(clientNode: ClientNode("client1"));

  final stopwatch = Stopwatch()..start();

  for (var i = 1; i <= maxEvents; i++) {
    final event = issueRawCreateEventFromNode(
      Node(
        id: 'tobeassigned',
        type: NodeTypes.document,
        lastModifiedAtTimestamp: 'tobedobe',
        userId: 'user1',
        isDeleted: false,
        content: NodeContent(NodeTypes.document, "author$i", "title$i", null),
      ),
      client,
    );

    // Time insertion if it's at an interval point
    if (i % interval == 0) {
      stopwatch.reset();
      await db.clientDrift.insertLocalEventWithClientId(event);
      final insertTime = stopwatch.elapsedMilliseconds;

      stopwatch.reset();
      await db.clientDrift.reduceAllEventsIntoNodes();
      final reduceTime = stopwatch.elapsedMilliseconds;

      print('$i,$insertTime,$reduceTime');
    } else {
      // Just insert without timing or reducing
      await db.clientDrift.insertLocalEventWithClientId(event);
    }
  }

  await db.close();
}
