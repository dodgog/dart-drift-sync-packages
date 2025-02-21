import 'package:backend/client_definitions.dart';

/// A client-specific reducer of all events into nodes
extension ClientNodeHelper on ClientDrift {
  // we use the fact that modular accessors are linked and so from
  // eventsDrift we go back a level to client drift and then into shared
  Future<List<Node>> reduceAllEventsIntoNodes() async {
    final deletedCount = await sharedNodesDrift.deleteAllNodes();

    final allEvents = await sharedEventsDrift.getEvents().get();

    final appliedCount = await sharedNodesDrift.applyListOfEvents(allEvents);

    return await sharedNodesDrift.getAllNodes().get();
  }
}
