// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_create_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeCreateResp _$VolumeCreateRespFromJson(Map<String, dynamic> json) =>
    VolumeCreateResp(
      anonymous: json['Anonymous'] as bool?,
      createdAt: json['CreatedAt'] as String?,
      driver: json['Driver'] as String?,
      mountCount: (json['MountCount'] as num?)?.toInt(),
      mountpoint: json['Mountpoint'] as String?,
      name: json['Name'] as String,
      scope: json['Scope'] as String?,
      timeout: (json['Timeout'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VolumeCreateRespToJson(VolumeCreateResp instance) =>
    <String, dynamic>{
      'Anonymous': instance.anonymous,
      'CreatedAt': instance.createdAt,
      'Driver': instance.driver,
      'MountCount': instance.mountCount,
      'Mountpoint': instance.mountpoint,
      'Name': instance.name,
      'Scope': instance.scope,
      'Timeout': instance.timeout,
    };
