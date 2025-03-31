// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_create_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeCreateReq _$VolumeCreateReqFromJson(Map<String, dynamic> json) =>
    VolumeCreateReq(
      driver: json['Driver'] as String,
      ignoreIfExists: json['IgnoreIfExists'] as bool,
      label: Map<String, String>.from(json['Label'] as Map),
      labels: Map<String, String>.from(json['Labels'] as Map),
      name: json['Name'] as String,
      options: Map<String, String>.from(json['Options'] as Map),
    );

Map<String, dynamic> _$VolumeCreateReqToJson(VolumeCreateReq instance) =>
    <String, dynamic>{
      'Driver': instance.driver,
      'IgnoreIfExists': instance.ignoreIfExists,
      'Label': instance.label,
      'Labels': instance.labels,
      'Name': instance.name,
      'Options': instance.options,
    };
