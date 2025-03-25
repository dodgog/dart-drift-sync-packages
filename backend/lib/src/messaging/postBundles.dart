import 'package:backend/messaging.dart';
import 'package:backend/server_definitions.dart';
import 'package:backend/shared_definitions.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'postBundles.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostBundlesQuery extends Query {
  String clientTimestamp;
  String lastIssuedServerTimestamp;
  @BundleConverter()
  List<Bundle> bundles;

  PostBundlesQuery(
    String userId,
    String token,
    this.clientTimestamp,
    this.lastIssuedServerTimestamp,
    this.bundles,
  ) : super(userId, token, "post_bundles_query");

  factory PostBundlesQuery.fromJson(Map<String, dynamic> json) =>
      _$PostBundlesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$PostBundlesQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostBundlesResponse extends QueryResponse {
  String lastIssuedServerTimestamp;
  @BundleConverter()
  List<Bundle> newBundles;
  List<String> insertedBundleIds;

  PostBundlesResponse(
    this.lastIssuedServerTimestamp,
    this.insertedBundleIds,
    this.newBundles,
  ) : super("post_bundles_response");

  factory PostBundlesResponse.fromJson(Map<String, dynamic> json) =>
      _$PostBundlesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostBundlesResponseToJson(this);
}
