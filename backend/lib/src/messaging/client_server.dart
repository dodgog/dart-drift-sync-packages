import 'package:backend/server_definitions.dart';
import 'package:backend/shared_definitions.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'client_server.g.dart';

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

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundleIdsQuery {
  String userId;
  String token;
  String? sinceTimestamp;

  GetBundleIdsQuery(this.userId, this.token, {this.sinceTimestamp});

  factory GetBundleIdsQuery.fromJson(Map<String, dynamic> json) =>
      _$GetBundleIdsQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundleIdsQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class GetBundleIdsResponse {
  List<String> bundleIds;

  // TODO: this probably should also have a timestamp since it is equivalent to
  // a regular pull

  GetBundleIdsResponse(this.bundleIds);

  factory GetBundleIdsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBundleIdsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBundleIdsResponseToJson(this);
}

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
