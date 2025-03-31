// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSummary _$ImageSummaryFromJson(Map<String, dynamic> json) => ImageSummary(
  arch: json['Arch'] as String,
  containers: (json['Containers'] as num).toInt(),
  created: (json['Created'] as num).toInt(),
  digest: json['Digest'] as String,
  id: json['Id'] as String,
  names: (json['Names'] as List<dynamic>?)?.map((e) => e as String).toList(),
  os: json['Os'] as String,
  size: (json['Size'] as num).toInt(),
  sharedSize: (json['SharedSize'] as num).toInt(),
  virtualSize: (json['VirtualSize'] as num).toInt(),
);

Map<String, dynamic> _$ImageSummaryToJson(ImageSummary instance) =>
    <String, dynamic>{
      'Arch': instance.arch,
      'Containers': instance.containers,
      'Created': instance.created,
      'Digest': instance.digest,
      'Id': instance.id,
      'Names': instance.names,
      'Os': instance.os,
      'Size': instance.size,
      'SharedSize': instance.sharedSize,
      'VirtualSize': instance.virtualSize,
    };
