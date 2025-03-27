import 'package:backend/client_definitions.dart';

import 'database.dart';

class NodeHelper {
  // think about work with isolates here and whether it should be a singleton

  NodeHelper(this._db);

  ClientDatabase _db;

// can create all supported node types: documentnodeobj, SimpleNodeObj
// creating them creates events and inserts them into the events table and
// attributes table
// the type it creates is ActionableObject<NodeObj>(NodeObj) with two
// methods.
// the objects that it creates have an editWith method and delete method
// which issue the events needed for this operation, apply them to the events
// table and attributes table, then fetch the mutated nodeobj from the
// database by fetching the node object of the same type and with the same id.

  // Creates a document node and returns an ActionableObject
  Future<ActionableObject<DocumentNodeObj>> create({
    required String author,
    required String title,
    String? url,
    NodeTypes? type,
  }) async {
    if (type != null && type != NodeTypes.document) {
      throw UnimplementedError("Only DocumentNodeObj is supported");
    }

    // Create document node events
    final events = createDocumentNode(
      author: author,
      title: title,
      url: url,
    );

    // Insert events into database
    for (final event in events) {
      await _db.clientDrift.insertLocalEventWithClientId(event);
      await _db.clientDrift.insertLocalEventIntoAttributes(event);
    }

    // Fetch the created node from database
    final entityId = events.first.entityId;

    final attributes =
        await _db.clientDrift.attributesDrift.getAttrubutesById(entityId);

    // Convert attributes to node object
    final nodeObj = NodeObj.fromAttributes(attributes);
    if (nodeObj == null) {
      throw NodeException('Failed to create document node');
    }

    if (nodeObj is! DocumentNodeObj) {
      throw NodeException('Created node is not a DocumentNodeObj');
    }

    return ActionableObject<DocumentNodeObj>(nodeObj, _db);
  }
}

class ActionableObject<T extends NodeObj> {
  final T nodeObj;
  final ClientDatabase _db;

  ActionableObject(this.nodeObj, this._db);

  // Edit a document node
  Future<DocumentNodeObj> edit({
    String? author,
    String? title,
    String? url,
  }) async {
    if (nodeObj is! DocumentNodeObj) {
      throw UnimplementedError("Only DocumentNodeObj editing is supported");
    }

    // Generate document modification events
    final events = modifyDocumentNode(
      nodeId: nodeObj.id,
      author: author,
      title: title,
      url: url,
    );

    if (events.isEmpty) {
      // No changes to apply
      return nodeObj as DocumentNodeObj;
    }

    // Insert events into database
    for (final event in events) {
      await _db.clientDrift.insertLocalEventWithClientId(event);
      await _db.clientDrift.insertLocalEventIntoAttributes(event);
    }

    // Fetch the updated node from database
    List<Attribute> attributes =
        await _db.clientDrift.attributesDrift.getAttrubutesById(nodeObj.id);

    // Convert attributes to node object
    final updatedNodeObj = NodeObj.fromAttributes(attributes);
    if (updatedNodeObj == null) {
      throw NodeException('Failed to retrieve updated document node');
    }

    if (updatedNodeObj is! DocumentNodeObj) {
      throw NodeException('Updated node is not a DocumentNodeObj');
    }

    return updatedNodeObj;
  }

  // Delete a node
  Future<void> delete() async {
    if (nodeObj is! DocumentNodeObj) {
      throw UnimplementedError("Only DocumentNodeObj deletion is supported");
    }

    // Create deletion event
    final event = deleteNode(nodeId: nodeObj.id);

    // Insert event into database
    await _db.clientDrift.insertLocalEventWithClientId(event);
    await _db.clientDrift.insertLocalEventIntoAttributes(event);
  }
}
