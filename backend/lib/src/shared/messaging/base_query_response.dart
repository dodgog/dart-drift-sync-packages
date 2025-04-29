import 'package:json_annotation/json_annotation.dart' as j;

import 'base_query.dart';

part 'base_query_response.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class QueryResponse<T extends BaseQuery> {
  String type;

  QueryResponse(this.type);

  factory QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$QueryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QueryResponseToJson(this);
}
