// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_inspect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerInspect _$ContainerInspectFromJson(Map<String, dynamic> json) =>
    ContainerInspect(
      id: json['Id'] as String,
      created:
          json['Created'] == null
              ? null
              : DateTime.parse(json['Created'] as String),
      args: (json['Args'] as List<dynamic>?)?.map((e) => e as String).toList(),
      state: ContainerState.fromJson(json['State'] as Map<String, dynamic>),
      image: json['Image'] as String,
      name: json['Name'] as String,
      restartCount: (json['RestartCount'] as num?)?.toInt(),
      platform: json['Platform'] as String?,
      hostConfig: ContainerHostConfig.fromJson(
        json['HostConfig'] as Map<String, dynamic>,
      ),
      mounts:
          (json['Mounts'] as List<dynamic>?)?.map((e) => e as Object).toList(),
      config: ContainerConfig.fromJson(json['Config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContainerInspectToJson(ContainerInspect instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Created': instance.created?.toIso8601String(),
      'Args': instance.args,
      'State': instance.state,
      'Image': instance.image,
      'Name': instance.name,
      'RestartCount': instance.restartCount,
      'Platform': instance.platform,
      'HostConfig': instance.hostConfig,
      'Mounts': instance.mounts,
      'Config': instance.config,
    };
