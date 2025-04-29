import 'package:backend/messaging.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'get_bundle_ids.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundleIdsQuery extends BaseQuery {
  /// When not provided signifies that all bundles are needed
  String? sinceTimestamp;

  GetBundleIdsQuery(String userId, String token, {this.sinceTimestamp})
      : super(userId, token, "get_bundle_ids_query");

  factory GetBundleIdsQuery.fromJson(Map<String, dynamic> json) =>
      _$GetBundleIdsQueryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBundleIdsQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundleIdsResponse extends QueryResponse<GetBundleIdsQuery> {
  List<String> bundleIds;

  /// When not provided signifies that all bundles are given
  String? sinceTimestamp;

  // TODO: this probably should also have a timestamp since it is equivalent to
  // a regular pull

  GetBundleIdsResponse(this.bundleIds, {this.sinceTimestamp})
      : super("get_bundle_ids_response");

  factory GetBundleIdsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBundleIdsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBundleIdsResponseToJson(this);
}
