import 'package:drift/drift.dart';

import 'event_types.dart';
import 'shared_events.drift.dart';
import 'shared_nodes.drift.dart';

// apply client time and server time as last modified fields
// later we should change it to using the vector clock ts

// with edits and deletes need to ensure that the node exists (by providing
// an object)

class UnsupportedEventException implements Exception {
  final String message;
  UnsupportedEventException(this.message);
}

class UnsupportedEventFormatException extends UnsupportedEventException {
  UnsupportedEventFormatException(super.message);
}

class NodeRetrievalException implements Exception {
  final String message;
  NodeRetrievalException(this.message);
}

extension Applicator on SharedNodesDrift {
  Future<Node> applyEvent(Event event) async {
    if (event.type == EventTypes.create) {
      final node = _createNodeFromCreateEvent(event);
      insertNode(
        id: node.id,
        type: node.type,
        serverTimeStamp: node.serverTimeStamp,
        clientTimeStamp: node.clientTimeStamp,
        userId: node.userId,
        isDeleted: node.isDeleted,
        content: node.content,
      );
    }

    if (event.targetNodeId == null) {
      throw UnsupportedEventFormatException(
          "Target nodeId is null in a mutation event");
    }

    final node = await getNodeById(id: event.targetNodeId!).getSingleOrNull() ??
        (throw NodeRetrievalException("There must be exactly one node "
            "with id"));

    late final Node replacedNode;

    switch (event.type) {
      case EventTypes.edit:
        replacedNode = _applyEditEventToNode(event, node);
      case EventTypes.delete:
        replacedNode = _applyDeleteEventToNode(event, node);
      default:
        throw UnsupportedEventException(
            "No such event supported ${event.type}");
    }

    mutateNodeById(
      serverTimeStamp: replacedNode.serverTimeStamp,
      clientTimeStamp: replacedNode.clientTimeStamp,
      userId: replacedNode.userId,
      isDeleted: replacedNode.isDeleted,
      content: replacedNode.content,
      id: replacedNode.id,
    );

    return replacedNode;
  }
}

bool _isEventAfterNodeLastModifiedTime(Event event, Node node){
  // vector clocks here would be nice
  return false;
}

Node _applyEditEventToNode(Event event, Node node) {
  assert(event.targetNodeId == node.id);
  assert(event.type == EventTypes.edit);

  return node.copyWith(
    content: event.content.nodeContent,
    clientTimeStamp: event.clientTimeStamp,
    serverTimeStamp: Value(event.serverTimeStamp),
  );
}

Node _applyDeleteEventToNode(Event event, Node node) {
  assert(event.targetNodeId == node.id);
  assert(event.type == EventTypes.delete);

  return node.copyWith(
    isDeleted: true,
    clientTimeStamp: event.clientTimeStamp,
    serverTimeStamp: Value(event.serverTimeStamp),
  );
}

Node _createNodeFromCreateEvent(Event event) {
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
