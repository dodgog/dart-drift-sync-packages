// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getBundles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBundlesQuery _$GetBundlesQueryFromJson(Map<String, dynamic> json) =>
    GetBundlesQuery(
      json['user_id'] as String,
      json['token'] as String,
      (json['bundle_ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetBundlesQueryToJson(GetBundlesQuery instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'token': instance.token,
      'bundle_ids': instance.bundleIds,
    };

GetBundlesResponse _$GetBundlesResponseFromJson(Map<String, dynamic> json) =>
    GetBundlesResponse(
      (json['bundles'] as List<dynamic>)
          .map((e) =>
              const BundleConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      json['last_issued_server_timestamp'] as String,
    );

Map<String, dynamic> _$GetBundlesResponseToJson(GetBundlesResponse instance) =>
    <String, dynamic>{
      'bundles': instance.bundles.map(const BundleConverter().toJson).toList(),
      'last_issued_server_timestamp': instance.lastIssuedServerTimestamp,
    };
