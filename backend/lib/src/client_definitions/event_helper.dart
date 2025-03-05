import 'package:backend/client_definitions.dart';

extension ClientEventHelper on ClientDrift {
  Future<int> insertLocalEventWithClientId(Event event) async {
    final client = await usersDrift.getCurrentClient().getSingle();
    return sharedEventsDrift.insertEvent(
      id: event.id,
      clientId: client.id,
      entityId: event.entityId,
      attribute: event.attribute,
      value: event.value,
      timestamp: event.timestamp,
    );
  }

  Future<int> insertLocalEventIntoAttributes(Event event) async {
    return sharedAttributesDrift.insertEventIntoAttributes(
      entityId: event.entityId,
      attribute: event.attribute,
      value: event.value,
      timestamp: event.timestamp,
    );
  }
}
