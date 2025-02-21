import 'package:backend/client_definitions.dart';
import 'package:uuidv7/uuidv7.dart';

// THINK what to make this an extension on? perhaps on a modular accessor?
extension ClientEventHelper on ClientDrift {
  Future<int> insertLocalEventWithClientId(Event event) async {
    final client = await usersDrift.getCurrentClient().getSingle();
    // THINK here about when timestamp id and client id are populated
    return await eventsDrift.insertLocalEvent(
      id: event.id,
      type: event.type,
      clientId: client.id,
      targetNodeId: event.targetNodeId,
      timestamp: event.timestamp,
      content: event.content,
    );
  }
}
