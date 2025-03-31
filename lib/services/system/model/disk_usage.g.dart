// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disk_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiskUsage _$DiskUsageFromJson(Map<String, dynamic> json) => DiskUsage(
  containers:
      (json['Containers'] as List<dynamic>)
          .map((e) => ContainerUsage.fromJson(e as Map<String, dynamic>))
          .toList(),
  images:
      (json['Images'] as List<dynamic>)
          .map((e) => ImageUsage.fromJson(e as Map<String, dynamic>))
          .toList(),
  volumes:
      (json['Volumes'] as List<dynamic>)
          .map((e) => VolumeUsage.fromJson(e as Map<String, dynamic>))
          .toList(),
  imagesSize: (json['ImagesSize'] as num).toInt(),
);

Map<String, dynamic> _$DiskUsageToJson(DiskUsage instance) => <String, dynamic>{
  'Containers': instance.containers,
  'Images': instance.images,
  'Volumes': instance.volumes,
  'ImagesSize': instance.imagesSize,
};
