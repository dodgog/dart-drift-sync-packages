// import 'package:backend/shared_definitions.dart';
import 'package:backend/client_library.dart';
import 'package:json_annotation/json_annotation.dart' as j;

//
part 'event_payload_encoder.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class EventPayload {
  @EventConverter()
  final List<Event> events;

  EventPayload({required this.events});

  factory EventPayload.fromJson(Map<String, dynamic> json) =>
      _$EventPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$EventPayloadToJson(this);
}
