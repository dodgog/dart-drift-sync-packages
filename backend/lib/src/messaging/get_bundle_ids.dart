import 'package:backend/messaging.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'get_bundle_ids.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundleIdsQuery extends BaseQuery {
  String? sinceTimestamp;

  GetBundleIdsQuery(String userId, String token, {this.sinceTimestamp})
      : super(userId, token, "get_bundle_ids_query");

  factory GetBundleIdsQuery.fromJson(Map<String, dynamic> json) =>
      _$GetBundleIdsQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundleIdsQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundleIdsResponse extends QueryResponse<GetBundleIdsQuery> {
  List<String> bundleIds;

  // TODO: this probably should also have a timestamp since it is equivalent to
  // a regular pull

  GetBundleIdsResponse(this.bundleIds) : super("get_bundle_ids_response");

  factory GetBundleIdsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBundleIdsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundleIdsResponseToJson(this);
}
