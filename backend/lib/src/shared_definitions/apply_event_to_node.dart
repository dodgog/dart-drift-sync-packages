import 'package:drift/drift.dart';

import 'event_types.dart';
import 'shared_events.drift.dart';
import 'shared_nodes.drift.dart';

// apply client time and server time as last modified fields
// later we should change it to using the vector clock ts

// with edits and deletes need to ensure that the node exists (by providing
// an object)

Node applyEditEventToNode(Event event, Node node) {
  assert(event.targetNodeId == node.id);
  assert(event.type == EventTypes.edit);

  return node.copyWith(
    content: event.content.nodeContent,
    clientTimeStamp: event.clientTimeStamp,
    serverTimeStamp: Value(event.serverTimeStamp),
  );
}

Node applyDeleteEventToNode(Event event, Node node) {
  assert(event.targetNodeId == node.id);
  assert(event.type == EventTypes.delete);

  return node.copyWith(
    isDeleted: true,
    clientTimeStamp: event.clientTimeStamp,
    serverTimeStamp: Value(event.serverTimeStamp),
  );
}

Node applyCreateEvent(Event event) {
  assert(event.targetNodeId != null);
  assert(event.type == EventTypes.create);

  return Node(
    id: event.targetNodeId!,
    clientTimeStamp: event.clientTimeStamp,
    serverTimeStamp: event.serverTimeStamp,
    userId: event.content.userId,
    isDeleted: false,
    content: event.content.nodeContent,
    type: event.content.nodeType,
  );
}
