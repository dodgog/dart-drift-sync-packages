import 'package:backend/messaging.dart';
import 'package:backend/server_definitions.dart';
import 'package:backend/shared_definitions.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'getBundles.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundlesQuery extends Query {
  List<String> bundleIds;

  GetBundlesQuery(String userId, String token, this.bundleIds)
      : super(userId, token, "get_bundles_query");

  factory GetBundlesQuery.fromJson(Map<String, dynamic> json) =>
      _$GetBundlesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundlesQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundlesResponse extends QueryResponse {
  @BundleConverter()
  List<Bundle> bundles;
  String lastIssuedServerTimestamp;

  GetBundlesResponse(this.bundles, this.lastIssuedServerTimestamp)
      : super("get_bundles_response");

  factory GetBundlesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBundlesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundlesResponseToJson(this);
}
