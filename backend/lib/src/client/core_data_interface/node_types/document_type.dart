part of '../types.dart';

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DocumentNodeObj &&
        super == other &&
        other.author == author &&
        other.title == title &&
        other.url == url;
  }

  @override
  int get hashCode => Object.hash(
        super.hashCode,
        author,
        title,
        url,
      );

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
