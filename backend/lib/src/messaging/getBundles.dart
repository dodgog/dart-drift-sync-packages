import 'package:backend/server_definitions.dart';
import 'package:backend/shared_definitions.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'getBundles.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundlesQuery {
  String userId;
  String token;
  List<String> bundleIds;

  GetBundlesQuery(this.userId, this.token, this.bundleIds);

  factory GetBundlesQuery.fromJson(Map<String, dynamic> json) =>
      _$GetBundlesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundlesQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundlesResponse {
  @BundleConverter()
  List<Bundle> bundles;
  String lastIssuedServerTimestamp;

  GetBundlesResponse(this.bundles, this.lastIssuedServerTimestamp);

  factory GetBundlesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBundlesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundlesResponseToJson(this);
}
