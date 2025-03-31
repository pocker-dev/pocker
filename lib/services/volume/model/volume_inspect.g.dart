// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_inspect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeInspect _$VolumeInspectFromJson(Map<String, dynamic> json) =>
    VolumeInspect(
      createdAt: json['CreatedAt'] as String,
      driver: json['Driver'] as String,
      labels: Map<String, String>.from(json['Labels'] as Map),
      mountpoint: json['Mountpoint'] as String,
      name: json['Name'] as String,
      options: Map<String, String>.from(json['Options'] as Map),
      scope: json['Scope'] as String,
    );

Map<String, dynamic> _$VolumeInspectToJson(VolumeInspect instance) =>
    <String, dynamic>{
      'CreatedAt': instance.createdAt,
      'Driver': instance.driver,
      'Labels': instance.labels,
      'Mountpoint': instance.mountpoint,
      'Name': instance.name,
      'Options': instance.options,
      'Scope': instance.scope,
    };
