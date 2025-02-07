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

  static JsonTypeConverter2<EventContent, Uint8List?, Object?> binaryConverter =
      TypeConverter.jsonb(
    fromJson: (json) => EventContent.fromJson(json as Map<String, Object?>),
    toJson: (pref) => pref.toJson(),
  );
}
