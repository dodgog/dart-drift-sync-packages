// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_payload_encoder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPayload _$EventPayloadFromJson(Map<String, dynamic> json) => EventPayload(
      events: (json['events'] as List<dynamic>)
          .map(
              (e) => const EventConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventPayloadToJson(EventPayload instance) =>
    <String, dynamic>{
      'events': instance.events.map(const EventConverter().toJson).toList(),
    };
