// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUsage _$ImageUsageFromJson(Map<String, dynamic> json) => ImageUsage(
  repository: json['Repository'] as String,
  tag: json['Tag'] as String,
  imageID: json['ImageID'] as String,
  created: DateTime.parse(json['Created'] as String),
  size: (json['Size'] as num).toInt(),
  sharedSize: (json['SharedSize'] as num).toInt(),
  uniqueSize: (json['UniqueSize'] as num).toInt(),
  containers: (json['Containers'] as num).toInt(),
);

Map<String, dynamic> _$ImageUsageToJson(ImageUsage instance) =>
    <String, dynamic>{
      'Repository': instance.repository,
      'Tag': instance.tag,
      'ImageID': instance.imageID,
      'Created': instance.created.toIso8601String(),
      'Size': instance.size,
      'SharedSize': instance.sharedSize,
      'UniqueSize': instance.uniqueSize,
      'Containers': instance.containers,
    };
