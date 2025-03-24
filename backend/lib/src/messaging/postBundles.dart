import 'package:backend/server_definitions.dart';
import 'package:backend/shared_definitions.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'postBundles.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostBundlesQuery {
  String token;
  String userId;
  String clientTimestamp;
  String lastIssuedServerTimestamp;
  @BundleConverter()
  List<Bundle> bundles;

  PostBundlesQuery(
    this.token,
    this.userId,
    this.clientTimestamp,
    this.lastIssuedServerTimestamp,
    this.bundles,
  );

  factory PostBundlesQuery.fromJson(Map<String, dynamic> json) =>
      _$PostBundlesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$PostBundlesQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostBundlesResponse {
  String lastIssuedServerTimestamp;
  @BundleConverter()
  List<Bundle> newBundles;
  List<String> insertedBundleIds;

  PostBundlesResponse(
    this.lastIssuedServerTimestamp,
    this.insertedBundleIds,
    this.newBundles,
  );

  factory PostBundlesResponse.fromJson(Map<String, dynamic> json) =>
      _$PostBundlesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostBundlesResponseToJson(this);
}
