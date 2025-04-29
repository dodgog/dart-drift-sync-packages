import 'package:json_annotation/json_annotation.dart' as j;

part 'base_query.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class BaseQuery {
  String userId;
  String token;
  String type;

  BaseQuery(this.userId, this.token, this.type);

  factory BaseQuery.fromJson(Map<String, dynamic> json) =>
      _$BaseQueryFromJson(json);

  Map<String, dynamic> toJson() => _$BaseQueryToJson(this);
}
