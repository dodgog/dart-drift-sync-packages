import 'dart:convert';

import '../attributes.drift.dart';
import 'attributes.dart';
import 'helper_string.dart';
import 'items.dart';

enum NodeTypes {
  document,
  simple,
}

class NodeException implements Exception {
  final String message;
  final dynamic originalError;

  NodeException(this.message, [this.originalError]);

  @override
  String toString() =>
      'NodeException: $message${originalError != null ? ' (Caused by: $originalError)' : ''}';
}

// AIUSE -- this was generated
// TODO -- clean up

class NodeObj {
  final String id;
  final NodeTypes type;
  final String lastModifiedAtTimestamp;
  final bool isDeleted;

  NodeObj({
    required this.id,
    required this.type,
    required this.lastModifiedAtTimestamp,
    required this.isDeleted,
  });

  static NodeObj? fromAttributes(List<Attribute> attributes) {
    if (attributes.isEmpty) return null;

    try {
      final entityId = attributes.first.entityId;
      final typeStr = getRequiredAttribute(attributes, 'type');

      final timestamp = attributes.map((e) => e.timestamp).maxStringOrNull();
      if (timestamp == null) throw NodeException('Missing timestamp');

      final isDeleted = getAttributeOrNull(attributes, 'is_deleted') == '1';

      final nodeType = NodeTypes.values.firstWhere(
        (t) => t.toString() == typeStr,
        orElse: () => throw NodeException('Invalid node type: $typeStr'),
      );

      final baseNode = NodeObj(
        id: entityId,
        type: nodeType,
        lastModifiedAtTimestamp: timestamp,
        isDeleted: isDeleted,
      );

      return switch (nodeType) {
        NodeTypes.document =>
          DocumentNodeObj.fromAttributes(attributes, baseNode),
        NodeTypes.simple => SimpleNodeObj.fromAttributes(attributes, baseNode),
      };
    } catch (e) {
      throw NodeException('Failed to create node', e);
    }
  }

  static List<T> fromAllAttributesTyped<T extends NodeObj>(
    List<Attribute> allAttributes,
    NodeTypes targetType,
  ) {
    final groupedAttributesByEntityId =
        allAttributes.fold<Map<String, List<Attribute>>>(
      {},
      (map, attr) {
        map.putIfAbsent(attr.entityId, () => []).add(attr);
        return map;
      },
    );

    return groupedAttributesByEntityId.values
        .map((attrs) => fromAttributes(attrs))
        // THINK more about this
        .whereType<T>()
        // THINK more about this
        .where((node) => node.type == targetType)
        .toList();
  }
}

class DocumentNodeObj extends NodeObj {
  final String author;
  final String title;
  final String? url;

  DocumentNodeObj({
    required super.id,
    required super.type,
    required super.lastModifiedAtTimestamp,
    required super.isDeleted,
    required this.author,
    required this.title,
    this.url,
  });

  static DocumentNodeObj fromAttributes(
      List<Attribute> attributes, NodeObj baseNode) {
    if (baseNode.type != NodeTypes.document) {
      throw NodeException("Creating document from different declared type");
    }

    return DocumentNodeObj(
      id: baseNode.id,
      type: baseNode.type,
      lastModifiedAtTimestamp: baseNode.lastModifiedAtTimestamp,
      isDeleted: baseNode.isDeleted,
      author: getRequiredAttribute(attributes, 'author'),
      title: getRequiredAttribute(attributes, 'title'),
      url: getAttributeOrNull(attributes, 'url'),
    );
  }

  static List<DocumentNodeObj> fromAllAttributes(
      List<Attribute> allAttributes) {
    return NodeObj.fromAllAttributesTyped(allAttributes, NodeTypes.document);
  }
}

class SimpleNodeObj extends NodeObj {
  final List<String> items;

  SimpleNodeObj({
    required super.id,
    required super.type,
    required super.lastModifiedAtTimestamp,
    required super.isDeleted,
    required this.items,
  });

  static SimpleNodeObj? fromAttributes(
      List<Attribute> attributes, NodeObj baseNode) {
    if (baseNode.type != NodeTypes.simple) {
      throw NodeException("Creating simple from different declared type");
    }

    List<String> items = [];
    try {
      final itemsJson = getRequiredAttribute(attributes, 'items');
      final itemsObj = Items.fromJson(jsonDecode(itemsJson));
      items = itemsObj.items;
    } catch (e) {
      print('Warning: Error parsing items JSON: $e');
    }

    return SimpleNodeObj(
      id: baseNode.id,
      type: baseNode.type,
      lastModifiedAtTimestamp: baseNode.lastModifiedAtTimestamp,
      isDeleted: baseNode.isDeleted,
      items: items,
    );
  }

  static List<SimpleNodeObj> fromAllAttributes(List<Attribute> allAttributes) {
    return NodeObj.fromAllAttributesTyped(allAttributes, NodeTypes.simple);
  }
}
