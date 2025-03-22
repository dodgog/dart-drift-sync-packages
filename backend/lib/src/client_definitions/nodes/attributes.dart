import '../attributes.drift.dart';

class AttributeException implements Exception {
  final String message;
  final dynamic originalError;

  AttributeException(this.message, [this.originalError]);

  @override
  String toString() =>
      'NodeException: $message${originalError != null ? ' (Caused by: $originalError)' : ''}';
}

String? getAttributeOrNull(List<Attribute> attributes, String attrName) {
  return attributes
      .where((attr) => attr.attribute == attrName)
      .firstOrNull
      ?.value;
}

String getRequiredAttribute(List<Attribute> attributes, String attrName) {
  final value = getAttributeOrNull(attributes, attrName);
  if (value == null) {
    throw AttributeException('Required attribute missing: $attrName');
  }
  return value;
}
