import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'event_content.g.dart';

@j.JsonSerializable()
class EventContent {
  bool receiveEmails;
  String selectedTheme;

  EventContent(this.receiveEmails, this.selectedTheme);

  factory EventContent.fromJson(Map<String, dynamic> json) =>
      _$EventContentFromJson(json);

  Map<String, dynamic> toJson() => _$EventContentToJson(this);

  static JsonTypeConverter2<EventContent, String?, Object?> converter =
      TypeConverter.json2(
    fromJson: (json) => EventContent.fromJson(json as Map<String, Object?>),
    toJson: (pref) => pref.toJson(),
  );
  static JsonTypeConverter2<EventContent, Uint8List?, Object?> binaryConverter =
      TypeConverter.jsonb(
    fromJson: (json) => EventContent.fromJson(json as Map<String, Object?>),
    toJson: (pref) => pref.toJson(),
  );
}

class EventContentConverter extends TypeConverter<EventContent, String>
// with JsonTypeConverter2<EventContent, String, Map<String, Object?>>
{
  const EventContentConverter();

  @override
  EventContent fromSql(String fromDb) {
    return fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(EventContent value) {
    return json.encode(toJson(value));
  }

  @override
  EventContent fromJson(Map<String, Object?> json) {
    return EventContent.fromJson(json);
  }

  @override
  Map<String, Object?> toJson(EventContent value) {
    return value.toJson();
  }
}
