import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'node_content.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class NodeContent {
  String author;
  String title;
  List<String> referencedObjectIds;

  NodeContent(this.author, this.title, this.referencedObjectIds);

  factory NodeContent.fromJson(Map<String, dynamic> json) =>
      _$NodeContentFromJson(json);

  Map<String, dynamic> toJson() => _$NodeContentToJson(this);

  static JsonTypeConverter2<NodeContent, Uint8List?, Object?> binaryConverter =
      TypeConverter.jsonb(
    fromJson: (json) => NodeContent.fromJson(json as Map<String, Object?>),
    toJson: (pref) => pref.toJson(),
  );
}
