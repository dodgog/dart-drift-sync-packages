import 'package:backend/shared_definitions.dart';

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
  /// Apply events against a database in one drift transaction
  Future<int> applyListOfEvents(List<Event> events) async {
    int counter = 0;
    for (final event in events) {
      final result = await applyEvent(event);
      if (result != null) counter++;
    }
    return counter;
  }

  /// Depending on the event type, parse the event, retreive relevant nodes,
  /// and if the LWW time ordering allows, create or mutate a node
  Future<Node?> applyEvent(Event event) async {
    if (event.type == EventTypes.create) {
      final node = _createNodeFromCreateEvent(event);
      insertNode(
        id: node.id,
        type: node.type,
        lastModifiedAtTimestamp: node.lastModifiedAtTimestamp,
        userId: node.userId,
        isDeleted: node.isDeleted,
        content: node.content,
      );
    }

    if (event.targetNodeId == null) {
      throw UnsupportedEventFormatException("Target nodeId is null in a mutation event");
    }

    final targetNode = await getNodeById(id: event.targetNodeId!).getSingleOrNull() ??
        (throw NodeRetrievalException("There must be exactly one node "
            "with id"));

    // Last Write Wins LWW
    if (!_isEventAfterNodeLastModifiedTime(event, targetNode)) {
      return null;
    }

    late final Node mutatedNode;

    switch (event.type) {
      case EventTypes.edit:
        mutatedNode = _applyEditEventToNode(event, targetNode);
      case EventTypes.delete:
        mutatedNode = _applyDeleteEventToNode(event, targetNode);
      default:
        throw UnsupportedEventException("No such event supported ${event.type}");
    }

    mutateNodeById(
      lastModifiedAtTimestamp:  mutatedNode.lastModifiedAtTimestamp,
      userId: mutatedNode.userId,
      isDeleted: mutatedNode.isDeleted,
      content: mutatedNode.content,
      id: mutatedNode.id,
    );

    return mutatedNode;
  }
}

bool _isEventAfterNodeLastModifiedTime(Event event, Node node) {
  return event.timestamp.compareTo(node.lastModifiedAtTimestamp) > 0;
}

// THINK: create is kind of like an edit, which is applied to a non-existing
// node at this stage
Node _createNodeFromCreateEvent(Event event) {
  assert(event.targetNodeId != null);
  assert(event.type == EventTypes.create);
  assert(event.content != null);
  assert(event.content!.eventType == event.type);

  return Node(
    id: event.targetNodeId!,
    lastModifiedAtTimestamp: event.timestamp,
    userId: event.content!.userId,
    isDeleted: false,
    content: event.content!.nodeContent,
    type: event.content!.nodeType,
  );
}

Node _applyEditEventToNode(Event event, Node node) {
  assert(event.type == EventTypes.edit);
  assert(event.content != null);
  assert(event.targetNodeId == node.id);
  assert(event.content!.eventType == event.type);

  return node.copyWith(
    content: event.content!.nodeContent,
    lastModifiedAtTimestamp: event.timestamp,
  );
}

Node _applyDeleteEventToNode(Event event, Node node) {
  assert(event.targetNodeId == node.id);
  assert(event.type == EventTypes.delete);
  assert(event.content == null);

  return node.copyWith(
    isDeleted: true,
    lastModifiedAtTimestamp: event.timestamp,
  );
}
