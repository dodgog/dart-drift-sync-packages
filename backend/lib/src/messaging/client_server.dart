import 'package:backend/server_definitions.dart';
import 'package:backend/shared_definitions.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'client_server.g.dart';

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostQuery {
  String token;
  String userId;
  String clientTimestamp;
  String lastIssuedServerTimestamp;
  @BundleConverter()
  List<Bundle> bundles;

  PostQuery(
    this.token,
    this.userId,
    this.clientTimestamp,
    this.lastIssuedServerTimestamp,
    this.bundles,
  );

  factory PostQuery.fromJson(Map<String, dynamic> json) =>
      _$PostQueryFromJson(json);

  Map<String, dynamic> toJson() => _$PostQueryToJson(this);
}

@j.JsonSerializable(fieldRename: j.FieldRename.snake)
class PostResponse {
  String lastIssuedServerTimestamp;
  @BundleConverter()
  List<Bundle> newBundles;
  List<String> insertedBundleIds;

  PostResponse(
    this.lastIssuedServerTimestamp,
    this.insertedBundleIds,
    this.newBundles,
  );

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}


