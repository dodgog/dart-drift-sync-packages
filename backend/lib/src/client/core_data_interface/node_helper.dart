import 'package:backend/client_library.dart';

class NodeHelper {
  // think about work with isolates here and whether it should be a singleton

  NodeHelper(this._db);

  final ClientDatabase _db;

// can create all supported node types: documentnodeobj, SimpleNodeObj
// creating them creates events and inserts them into the events table and
// attributes table
// the type it creates is ActionableObject<NodeObj>(NodeObj) with two
// methods.
// the objects that it creates have an editWith method and delete method
// which issue the events needed for this operation, apply them to the events
// table and attributes table, then fetch the mutated nodeobj from the
// database by fetching the node object of the same type and with the same id.

  Future<Stream<void>> watch() async {
    final attributesStream =
        _db.clientDrift.attributesDrift.getAttributes().watch();
    final voidStream = attributesStream.map((attributes) => ());
    return voidStream;
  }

  Future<List<ActionableNodeObject<DocumentNodeObj>>> getAllDocuments() async {
    final attributes = await _db.clientDrift.attributesDrift.getAttributes()
        .get();
    final documents = DocumentNodeObj.fromAllAttributes(attributes);
    return documents.map((e) => ActionableNodeObject(e, _db)).toList();
  }

  // Creates a document node and returns an ActionableObject
  Future<ActionableNodeObject<DocumentNodeObj>> create({
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

    await _db.transaction(() async {
      for (final event in events) {
        await _db.clientDrift.insertLocalEventWithClientId(event);
        await _db.clientDrift.insertEventIntoAttributes(event);
      }
    });

    // Fetch the created node from database
    final entityId = events.first.entityId;

    final attributes =
        await _db.clientDrift.attributesDrift.getAttributesById(entityId);

    final nodeObj = NodeObj.fromAttributes(attributes);
    if (nodeObj == null) {
      throw NodeException('Failed to create document node');
    }

    if (nodeObj is! DocumentNodeObj) {
      throw NodeException('Created node is not a DocumentNodeObj');
    }

    return ActionableNodeObject<DocumentNodeObj>(nodeObj, _db);
  }
}

class ActionableNodeObject<T extends NodeObj> {
  T _nodeObj;
  final ClientDatabase _db;

  T get nodeObj {
    return _nodeObj;
  }

  ActionableNodeObject(this._nodeObj, this._db);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ActionableNodeObject<T> && other._nodeObj == _nodeObj;
  }

  @override
  int get hashCode => _nodeObj.hashCode;

  // Edit a document node
  Future<ActionableNodeObject<T>> edit({
    String? author,
    String? title,
    String? url,
  }) async {
    if (_nodeObj is! DocumentNodeObj) {
      throw UnimplementedError("Only DocumentNodeObj editing is supported");
    }

    // Generate document modification events
    final events = modifyDocumentNode(
      nodeId: _nodeObj.id,
      author: author,
      title: title,
      url: url,
    );

    if (events.isEmpty) {
      // No changes to apply
      return this;
    }

    await _db.transaction(() async {
      for (final event in events) {
        await _db.clientDrift.insertLocalEventWithClientId(event);
        await _db.clientDrift.insertEventIntoAttributes(event);
      }
    });

    // Fetch the updated node from database
    List<Attribute> attributes =
        await _db.clientDrift.attributesDrift.getAttributesById(_nodeObj.id);

    // Convert attributes to node object
    final updatedNodeObj = NodeObj.fromAttributes(attributes);
    if (updatedNodeObj == null) {
      throw NodeException('Failed to retrieve updated document node');
    }

    if (updatedNodeObj is! DocumentNodeObj) {
      throw NodeException('Updated node is not a DocumentNodeObj');
    }

    _nodeObj = updatedNodeObj as T;
    this._nodeObj = _nodeObj;
    return this;
  }

  // Delete a node
  Future<T> delete() async {
    if (_nodeObj is! DocumentNodeObj) {
      throw UnimplementedError("Only DocumentNodeObj deletion is supported");
    }

    // Create deletion event
    final event = deleteNode(nodeId: _nodeObj.id);

    await _db.transaction(() async {
      await _db.clientDrift.insertLocalEventWithClientId(event);
      await _db.clientDrift.insertEventIntoAttributes(event);
    });

    List<Attribute> attributes =
        await _db.clientDrift.attributesDrift.getAttributesById(_nodeObj.id);

    // Convert attributes to node object
    final updatedNodeObj = NodeObj.fromAttributes(attributes);
    if (updatedNodeObj == null) {
      throw NodeException('Failed to retrieve updated document node');
    }

    _nodeObj = updatedNodeObj as T;
    return updatedNodeObj;
  }
}

// Compare two document lists regardless of order
bool doActionableNodeListsContainSameNodeIds(
  List<ActionableNodeObject<NodeObj>> list1,
  List<ActionableNodeObject<NodeObj>> list2,
) {
  if (list1.length != list2.length) return false;

  return list1.toSet().containsAll(list2);
}
