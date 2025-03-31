// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeSummary _$VolumeSummaryFromJson(Map<String, dynamic> json) =>
    VolumeSummary(
      anonymous: json['Anonymous'] as bool?,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      driver: json['Driver'] as String,
      mountCount: (json['MountCount'] as num).toInt(),
      mountpoint: json['Mountpoint'] as String,
      name: json['Name'] as String,
    );

Map<String, dynamic> _$VolumeSummaryToJson(VolumeSummary instance) =>
    <String, dynamic>{
      'Anonymous': instance.anonymous,
      'CreatedAt': instance.createdAt.toIso8601String(),
      'Driver': instance.driver,
      'MountCount': instance.mountCount,
      'Mountpoint': instance.mountpoint,
      'Name': instance.name,
    };
