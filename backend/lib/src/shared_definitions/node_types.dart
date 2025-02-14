import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;

import 'package:backend/client_definitions.dart';

enum NodeTypes {
  document,
}

@j.JsonSerializable()
class NodeTypeConverter extends j.JsonConverter<NodeTypes, String> {
  // drift default converter, imported from a generated file
  static JsonTypeConverter2<NodeTypes, String, String> converter =
      Nodes.$convertertype;

  const NodeTypeConverter();

  @override
  NodeTypes fromJson(String json) => converter.fromJson(json);

  @override
  String toJson(NodeTypes object) => converter.toJson(object);
}
