// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostQuery _$PostQueryFromJson(Map<String, dynamic> json) => PostQuery(
      json['token'] as String,
      json['user_id'] as String,
      json['last_issued_server_timestamp'] as String?,
      (json['events'] as List<dynamic>)
          .map(
              (e) => const EventConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostQueryToJson(PostQuery instance) => <String, dynamic>{
      'token': instance.token,
      'user_id': instance.userId,
      'last_issued_server_timestamp': instance.lastIssuedServerTimestamp,
      'events': instance.events.map(const EventConverter().toJson).toList(),
    };

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) => PostResponse(
      json['last_issued_server_timestamp'] as String,
      (json['events'] as List<dynamic>)
          .map(
              (e) => const EventConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'last_issued_server_timestamp': instance.lastIssuedServerTimestamp,
      'events': instance.events.map(const EventConverter().toJson).toList(),
    };

EventConverter _$EventConverterFromJson(Map<String, dynamic> json) =>
    EventConverter();

Map<String, dynamic> _$EventConverterToJson(EventConverter instance) =>
    <String, dynamic>{};
