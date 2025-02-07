import 'package:backend/server_definitions.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'client_server.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostQuery {
  String token;
  String userId;
  String lastIssuedServerTimestamp;
  @EventConverter()
  List<Event> events;

  PostQuery(
      this.token, this.userId, this.lastIssuedServerTimestamp, this.events);

  factory PostQuery.fromJson(Map<String, dynamic> json) =>
      _$PostQueryFromJson(json);

  Map<String, dynamic> toJson() => _$PostQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostResponse {
  String lastIssuedServerTimestamp;
  @EventConverter()
  List<Event> events;

  PostResponse(this.lastIssuedServerTimestamp, this.events);

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}

@j.JsonSerializable()
class EventConverter extends j.JsonConverter<Event, Map<String, dynamic>> {
  const EventConverter();

  @override
  Event fromJson(Map<String, dynamic> json) => Event.fromJson(json);

  @override
  Map<String, dynamic> toJson(Event object) => object.toJson();
}
