// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postBundles.dart';

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
