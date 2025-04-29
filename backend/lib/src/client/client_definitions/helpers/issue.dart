import 'package:backend/shared_definitions.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:uuidv7/uuidv7.dart';
import 'package:backend/client_xd.dart';


/// todo make these executable in the context of client

/// Creates a base event with missing client ID that will be populated during insertion
Event createEventWithMissingClient({
  required String entityId,
  required String attribute,
  required String value,
}) {
  return Event(
    id: generateUuidV7String(),
    clientId: "toPopulate",
    entityId: entityId,
    attribute: attribute,
    value: value,
    timestamp: HLC().issueLocalEventPacked(),
  );
}

/// Creates a new node with basic attributes
List<Event> _createNode({
  required NodeTypes type,
}) {
  final entityId = generateUuidV7String();

  return [
    createEventWithMissingClient(
      entityId: entityId,
      attribute: "type",
      value: type.toString(),
    ),
  ];
}

/// Creates a new document node with all required attributes
List<Event> createDocumentNode({
  required String author,
  required String title,
  String? url,
}) {
  final events = _createNode(type: NodeTypes.document);
  final entityId = events.first.entityId;

  events.addAll([
    createEventWithMissingClient(
      entityId: entityId,
      attribute: "author",
      value: author,
    ),
    createEventWithMissingClient(
      entityId: entityId,
      attribute: "title",
      value: title,
    ),
  ]);

  if (url != null) {
    events.add(
      createEventWithMissingClient(
        entityId: entityId,
        attribute: "url",
        value: url,
      ),
    );
  }

  return events;
}

/// Modifies an existing node's attribute
Event _modifyNode({
  required String nodeId,
  required String attribute,
  required String value,
}) {
  return createEventWithMissingClient(
    entityId: nodeId,
    attribute: attribute,
    value: value,
  );
}

/// Modifies a document node's attributes
List<Event> modifyDocumentNode({
  required String nodeId,
  String? author,
  String? title,
  String? url,
}) {
  final events = <Event>[];

  if (author != null) {
    events.add(_modifyNode(
      nodeId: nodeId,
      attribute: "author",
      value: author,
    ));
  }

  if (title != null) {
    events.add(_modifyNode(
      nodeId: nodeId,
      attribute: "title",
      value: title,
    ));
  }

  if (url != null) {
    events.add(_modifyNode(
      nodeId: nodeId,
      attribute: "url",
      value: url,
    ));
  }

  return events;
}

/// Marks a node as deleted
Event deleteNode({
  required String nodeId,
}) {
  return createEventWithMissingClient(
    entityId: nodeId,
    attribute: "is_deleted",
    value: "1",
  );
}
