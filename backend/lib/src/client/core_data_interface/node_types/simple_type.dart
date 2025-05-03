part of '../types.dart';

class SimpleNodeObj extends NodeObj {
  Items items;

  SimpleNodeObj({
    required super.id,
    required super.type,
    required super.lastModifiedAtTimestamp,
    required super.isDeleted,
    required this.items,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SimpleNodeObj &&
        super == other &&
        _listEquals(other.items.items, items.items);
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        Object.hashAll(items.items),
      );

  // AIUSE
  // AIGen
  // Helper method to compare lists since List equality is reference-based by default
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static SimpleNodeObj? fromAttributes(
      List<Attribute> attributes, NodeObj baseNode) {
    if (baseNode.type != NodeTypes.simple) {
      throw NodeException("Creating simple from different declared type");
    }

    Items items2 = Items([]);
    try {
      final itemsJson = getRequiredAttribute(attributes, 'items');
      final itemsObj = Items.fromJson(jsonDecode(itemsJson));
      items2 = itemsObj;
    } catch (e) {
      print('Warning: Error parsing items JSON: $e');
    }

    return SimpleNodeObj(
      id: baseNode.id,
      type: baseNode.type,
      lastModifiedAtTimestamp: baseNode.lastModifiedAtTimestamp,
      isDeleted: baseNode.isDeleted,
      items: items2,
    );
  }

  static List<SimpleNodeObj> fromAllAttributes(List<Attribute> allAttributes) {
    return NodeObj.fromAllAttributesTyped(allAttributes, NodeTypes.simple);
  }
}
