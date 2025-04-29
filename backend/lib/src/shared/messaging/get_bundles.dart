import 'package:backend/shared_library.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'get_bundles.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundlesQuery extends BaseQuery {
  List<String> bundleIds;

  GetBundlesQuery(String userId, String token, this.bundleIds)
      : super(userId, token, "get_bundles_query");

  factory GetBundlesQuery.fromJson(Map<String, dynamic> json) =>
      _$GetBundlesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundlesQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundlesResponse extends QueryResponse<GetBundlesQuery> {
  @BundleConverter()
  List<Bundle> bundles;

  GetBundlesResponse(this.bundles) : super("get_bundles_response");

  factory GetBundlesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBundlesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundlesResponseToJson(this);
}
