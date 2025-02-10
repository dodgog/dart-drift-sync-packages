// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventContent _$EventContentFromJson(Map<String, dynamic> json) => EventContent(
      json['wow'] as String,
      json['user_id'] as String,
      const NodeTypeConverter().fromJson(json['node_type'] as String),
      NodeContent.fromJson(json['node_content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventContentToJson(EventContent instance) =>
    <String, dynamic>{
      'wow': instance.wow,
      'user_id': instance.userId,
      'node_type': const NodeTypeConverter().toJson(instance.nodeType),
      'node_content': instance.nodeContent,
    };

NodeTypeConverter _$NodeTypeConverterFromJson(Map<String, dynamic> json) =>
    NodeTypeConverter();

Map<String, dynamic> _$NodeTypeConverterToJson(NodeTypeConverter instance) =>
    <String, dynamic>{};
