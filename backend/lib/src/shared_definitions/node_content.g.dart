// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeContent _$NodeContentFromJson(Map<String, dynamic> json) => NodeContent(
      json['author'] as String,
      json['title'] as String,
      (json['referenced_object_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$NodeContentToJson(NodeContent instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'referenced_object_ids': instance.referencedObjectIds,
    };
