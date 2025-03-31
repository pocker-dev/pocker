// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  type: json['Type'] as String,
  action: json['Action'] as String,
  id: json['id'] as String,
  status: json['status'] as String,
  time: (json['time'] as num).toInt(),
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'Type': instance.type,
  'Action': instance.action,
  'id': instance.id,
  'status': instance.status,
  'time': instance.time,
};
