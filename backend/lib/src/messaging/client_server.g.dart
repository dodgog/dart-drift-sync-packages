// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostBundlesQuery _$PostBundlesQueryFromJson(Map<String, dynamic> json) =>
    PostBundlesQuery(
      json['token'] as String,
      json['user_id'] as String,
      json['client_timestamp'] as String,
      json['last_issued_server_timestamp'] as String,
      (json['bundles'] as List<dynamic>)
          .map((e) =>
              const BundleConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostBundlesQueryToJson(PostBundlesQuery instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user_id': instance.userId,
      'client_timestamp': instance.clientTimestamp,
      'last_issued_server_timestamp': instance.lastIssuedServerTimestamp,
      'bundles': instance.bundles.map(const BundleConverter().toJson).toList(),
    };

PostBundlesResponse _$PostBundlesResponseFromJson(Map<String, dynamic> json) =>
    PostBundlesResponse(
      json['last_issued_server_timestamp'] as String,
      (json['inserted_bundle_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['new_bundles'] as List<dynamic>)
          .map((e) =>
              const BundleConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostBundlesResponseToJson(
        PostBundlesResponse instance) =>
    <String, dynamic>{
      'last_issued_server_timestamp': instance.lastIssuedServerTimestamp,
      'new_bundles':
          instance.newBundles.map(const BundleConverter().toJson).toList(),
      'inserted_bundle_ids': instance.insertedBundleIds,
    };

GetBundleIdsQuery _$GetBundleIdsQueryFromJson(Map<String, dynamic> json) =>
    GetBundleIdsQuery(
      json['user_id'] as String,
      json['token'] as String,
      sinceTimestamp: json['since_timestamp'] as String?,
    );

Map<String, dynamic> _$GetBundleIdsQueryToJson(GetBundleIdsQuery instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'token': instance.token,
      'since_timestamp': instance.sinceTimestamp,
    };

GetBundleIdsResponse _$GetBundleIdsResponseFromJson(
        Map<String, dynamic> json) =>
    GetBundleIdsResponse(
      (json['bundle_ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetBundleIdsResponseToJson(
        GetBundleIdsResponse instance) =>
    <String, dynamic>{
      'bundle_ids': instance.bundleIds,
    };

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
