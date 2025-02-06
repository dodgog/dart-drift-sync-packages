// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventContent _$EventContentFromJson(Map<String, dynamic> json) => EventContent(
      json['receiveEmails'] as bool,
      json['selectedTheme'] as String,
    );

Map<String, dynamic> _$EventContentToJson(EventContent instance) =>
    <String, dynamic>{
      'receiveEmails': instance.receiveEmails,
      'selectedTheme': instance.selectedTheme,
    };
