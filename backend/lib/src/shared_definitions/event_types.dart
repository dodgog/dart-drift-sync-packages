import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;

import 'package:backend/client_definitions.dart';

enum EventTypes {
  create,
  edit,
  delete,
}

@j.JsonSerializable()
class EventTypeConverter extends j.JsonConverter<EventTypes, String> {
  // drift default converter, imported from a generated file
  static JsonTypeConverter2<EventTypes, String, String> converter =
      Events.$convertertype;

  const EventTypeConverter();

  @override
  EventTypes fromJson(String json) => converter.fromJson(json);

  @override
  String toJson(EventTypes object) => converter.toJson(object);
}
