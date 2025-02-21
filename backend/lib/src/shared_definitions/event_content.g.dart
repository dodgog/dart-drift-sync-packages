// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventContent _$EventContentFromJson(Map<String, dynamic> json) => EventContent(
      json['wow'] as String,
      json['user_id'] as String,
      const EventTypeConverter().fromJson(json['event_type'] as String),
      const NodeTypeConverter().fromJson(json['node_type'] as String),
      const NodeContentConverter()
          .fromJson(json['node_content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventContentToJson(EventContent instance) =>
    <String, dynamic>{
      'wow': instance.wow,
      'user_id': instance.userId,
      'event_type': const EventTypeConverter().toJson(instance.eventType),
      'node_type': const NodeTypeConverter().toJson(instance.nodeType),
      'node_content': const NodeContentConverter().toJson(instance.nodeContent),
    };
