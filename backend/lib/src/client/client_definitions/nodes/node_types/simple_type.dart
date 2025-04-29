part of '../types.dart';

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
