import 'package:backend/shared_xd.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'post_bundles.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostBundlesQuery extends BaseQuery {
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
class PostBundlesResponse extends QueryResponse<PostBundlesQuery> {
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
