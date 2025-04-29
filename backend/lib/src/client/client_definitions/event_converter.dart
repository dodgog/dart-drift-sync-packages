import 'package:json_annotation/json_annotation.dart' as j;

import 'package:backend/client_definitions.dart';
import 'package:backend/client_xd.dart';

part 'event_converter.g.dart';

@j.JsonSerializable()
class EventConverter extends j.JsonConverter<Event, Map<String, dynamic>> {
  const EventConverter();

  @override
  Event fromJson(Map<String, dynamic> json) => Event.fromJson(json);

  @override
  Map<String, dynamic> toJson(Event object) => object.toJson();
}
