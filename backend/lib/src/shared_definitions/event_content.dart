import 'package:backend/client_definitions.dart';
import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'event_content.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class EventContent {
  String wow;
  String userId;
  // TODO: include type, which is normally also a part of the event object for
  //  debugging
  @EventTypeConverter()
  EventTypes eventType;
  @NodeTypeConverter()
  NodeTypes nodeType;
  @NodeContentConverter()
  NodeContent nodeContent;

  EventContent(
      this.wow, this.userId, this.eventType, this.nodeType, this.nodeContent,);

  factory EventContent.fromJson(Map<String, dynamic> json) =>
      _$EventContentFromJson(json);

  Map<String, dynamic> toJson() => _$EventContentToJson(this);

  // TODO: had to use dynamic type because Object? complains
  // TODO: couldn't reproduce on a smaller sample
  // below this definition is another work-around for nullability issues
  static JsonTypeConverter2<EventContent, Uint8List, dynamic> binaryConverter =
      TypeConverter.jsonb(
    fromJson: (Object? json) =>
        EventContent.fromJson(json as Map<String, Object?>),
    toJson: (EventContent pref) => pref.toJson(),
  );

// static JsonTypeConverter2<EventContent, Uint8List, Object?>
// // static JsonTypeConverter2<EventContent?, Uint8List?, Object?>
//     binaryConverter = TypeConverter.jsonb(
//   fromJson: (Object? json) {
//     if (json == null) return null;
//     return EventContent.fromJson(json as Map<String, Object?>);
//   },
//     toJson: (EventContent? pref) => pref?.toJson(),
// );
}
