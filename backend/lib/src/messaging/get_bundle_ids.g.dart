// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bundle_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBundleIdsQuery _$GetBundleIdsQueryFromJson(Map<String, dynamic> json) =>
    GetBundleIdsQuery(
      json['user_id'] as String,
      json['token'] as String,
      sinceTimestamp: json['since_timestamp'] as String?,
    )..type = json['type'] as String;

Map<String, dynamic> _$GetBundleIdsQueryToJson(GetBundleIdsQuery instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'token': instance.token,
      'type': instance.type,
      'since_timestamp': instance.sinceTimestamp,
    };

GetBundleIdsResponse _$GetBundleIdsResponseFromJson(
        Map<String, dynamic> json) =>
    GetBundleIdsResponse(
      (json['bundle_ids'] as List<dynamic>).map((e) => e as String).toList(),
    )..type = json['type'] as String;

Map<String, dynamic> _$GetBundleIdsResponseToJson(
        GetBundleIdsResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'bundle_ids': instance.bundleIds,
    };
