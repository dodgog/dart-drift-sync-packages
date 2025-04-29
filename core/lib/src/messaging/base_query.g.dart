// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseQuery _$BaseQueryFromJson(Map<String, dynamic> json) => BaseQuery(
      json['user_id'] as String,
      json['token'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$BaseQueryToJson(BaseQuery instance) => <String, dynamic>{
      'user_id': instance.userId,
      'token': instance.token,
      'type': instance.type,
    };
