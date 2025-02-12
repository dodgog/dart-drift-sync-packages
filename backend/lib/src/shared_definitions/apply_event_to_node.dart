import 'package:backend/src/shared_definitions/utils/date_comparators.dart';
import 'package:drift/drift.dart';

import 'package:backend/client_definitions.dart';

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
  Future<Node?> applyEvent(Event event) async {
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

    final targetNode = await getNodeById(id: event.targetNodeId!).getSingleOrNull() ??
        (throw NodeRetrievalException("There must be exactly one node "
            "with id"));

    // Last Write Wins LWW
    if (!_isEventAfterNodeLastModifiedTime(event, targetNode)){
      return null;
    }

    late final Node mutatedNode;

    switch (event.type) {
      case EventTypes.edit:
        mutatedNode = _applyEditEventToNode(event, targetNode);
      case EventTypes.delete:
        mutatedNode = _applyDeleteEventToNode(event, targetNode);
      default:
        throw UnsupportedEventException(
            "No such event supported ${event.type}");
    }

    mutateNodeById(
      serverTimeStamp: mutatedNode.serverTimeStamp,
      clientTimeStamp: mutatedNode.clientTimeStamp,
      userId: mutatedNode.userId,
      isDeleted: mutatedNode.isDeleted,
      content: mutatedNode.content,
      id: mutatedNode.id,
    );

    return mutatedNode;
  }
}

bool _isEventAfterNodeLastModifiedTime(Event event, Node node) {
  // vector clocks here would be nice
  return WeirdDate.fromEvent(event) > WeirdDate.fromNode(node);
}

Node _applyEditEventToNode(Event event, Node node) {
  assert(event.type == EventTypes.edit);
  assert(event.content != null);
  assert(event.targetNodeId == node.id);

  return node.copyWith(
    content: event.content!.nodeContent,
    clientTimeStamp: event.clientTimeStamp,
    serverTimeStamp: Value(event.serverTimeStamp),
  );
}

Node _applyDeleteEventToNode(Event event, Node node) {
  assert(event.targetNodeId == node.id);
  assert(event.type == EventTypes.delete);
  assert(event.content == null);

  return node.copyWith(
    isDeleted: true,
    clientTimeStamp: event.clientTimeStamp,
    serverTimeStamp: Value(event.serverTimeStamp),
  );
}

Node _createNodeFromCreateEvent(Event event) {
  assert(event.targetNodeId != null);
  assert(event.type == EventTypes.create);
  assert(event.content != null);

  return Node(
    id: event.targetNodeId!,
    clientTimeStamp: event.clientTimeStamp,
    serverTimeStamp: event.serverTimeStamp,
    userId: event.content!.userId,
    isDeleted: false,
    content: event.content!.nodeContent,
    type: event.content!.nodeType,
  );
}
