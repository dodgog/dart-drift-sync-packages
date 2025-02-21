// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeContent _$NodeContentFromJson(Map<String, dynamic> json) => NodeContent(
      const NodeTypeConverter().fromJson(json['node_type'] as String),
      json['author'] as String?,
      json['title'] as String?,
      (json['referenced_object_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$NodeContentToJson(NodeContent instance) =>
    <String, dynamic>{
      'node_type': const NodeTypeConverter().toJson(instance.nodeType),
      'author': instance.author,
      'title': instance.title,
      'referenced_object_ids': instance.referencedObjectIds,
    };

NodeContentConverter _$NodeContentConverterFromJson(
        Map<String, dynamic> json) =>
    NodeContentConverter();

Map<String, dynamic> _$NodeContentConverterToJson(
        NodeContentConverter instance) =>
    <String, dynamic>{};
