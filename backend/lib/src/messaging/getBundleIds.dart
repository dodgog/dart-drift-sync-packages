import 'package:backend/server_definitions.dart';
import 'package:backend/shared_definitions.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'getBundleIds.g.dart';

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

