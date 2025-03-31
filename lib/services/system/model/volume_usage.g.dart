// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeUsage _$VolumeUsageFromJson(Map<String, dynamic> json) => VolumeUsage(
  volumeName: json['VolumeName'] as String,
  links: (json['Links'] as num).toInt(),
  size: (json['Size'] as num).toInt(),
  reclaimableSize: (json['ReclaimableSize'] as num).toInt(),
);

Map<String, dynamic> _$VolumeUsageToJson(VolumeUsage instance) =>
    <String, dynamic>{
      'VolumeName': instance.volumeName,
      'Links': instance.links,
      'Size': instance.size,
      'ReclaimableSize': instance.reclaimableSize,
    };
