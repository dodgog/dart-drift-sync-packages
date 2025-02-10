import 'package:backend/client_definitions.dart';
import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;


part 'event_content.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class EventContent {
  String wow;
  String userId;
  @NodeTypeConverter()
  NodeTypes nodeType;
  NodeContent nodeContent;

  EventContent(this.wow, this.userId, this.nodeType, this.nodeContent);

  factory EventContent.fromJson(Map<String, dynamic> json) =>
      _$EventContentFromJson(json);

  Map<String, dynamic> toJson() => _$EventContentToJson(this);

  static JsonTypeConverter2<EventContent, Uint8List?, Object?> binaryConverter =
      TypeConverter.jsonb(
    fromJson: (json) => EventContent.fromJson(json as Map<String, Object?>),
    toJson: (pref) => pref.toJson(),
  );
}

@j.JsonSerializable()
class NodeTypeConverter extends j.JsonConverter<NodeTypes, String> {
  // drift default converter, imported from a generated file
  static JsonTypeConverter2<NodeTypes, String, String> converter = Nodes
      .$convertertype;

  const NodeTypeConverter();

  @override
  NodeTypes fromJson(String json) => converter.fromJson(json);

  @override
  String toJson(NodeTypes object) => converter.toJson(object);
}
