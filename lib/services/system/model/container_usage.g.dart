// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerUsage _$ContainerUsageFromJson(Map<String, dynamic> json) =>
    ContainerUsage(
      containerID: json['ContainerID'] as String,
      image: json['Image'] as String,
      command:
          (json['Command'] as List<dynamic>?)?.map((e) => e as String).toList(),
      localVolumes: (json['LocalVolumes'] as num).toInt(),
      size: (json['Size'] as num).toInt(),
      rWSize: (json['RWSize'] as num).toInt(),
      created: DateTime.parse(json['Created'] as String),
      status: json['Status'] as String,
      names: json['Names'] as String,
    );

Map<String, dynamic> _$ContainerUsageToJson(ContainerUsage instance) =>
    <String, dynamic>{
      'ContainerID': instance.containerID,
      'Image': instance.image,
      'Command': instance.command,
      'LocalVolumes': instance.localVolumes,
      'Size': instance.size,
      'RWSize': instance.rWSize,
      'Created': instance.created.toIso8601String(),
      'Status': instance.status,
      'Names': instance.names,
    };
