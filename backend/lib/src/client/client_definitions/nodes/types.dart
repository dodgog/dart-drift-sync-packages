import 'dart:convert';

import '../attributes.drift.dart';
import 'attributes.dart';
import 'utils/string_compare.dart';
import 'items.dart';

part 'node_types/document_type.dart';
part 'node_types/simple_type.dart';

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NodeObj &&
        other.id == id &&
        other.type == type &&
        other.lastModifiedAtTimestamp == lastModifiedAtTimestamp &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode => Object.hash(id, type, lastModifiedAtTimestamp, isDeleted);

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
