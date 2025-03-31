// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_host_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerHostConfig _$ContainerHostConfigFromJson(Map<String, dynamic> json) =>
    ContainerHostConfig(
      autoRemove: json['AutoRemove'] as bool?,
      privileged: json['Privileged'] as bool?,
      publishAllPorts: json['PublishAllPorts'] as bool?,
      readonlyRootfs: json['ReadonlyRootfs'] as bool?,
      ulimits:
          (json['Ulimits'] as List<dynamic>)
              .map((e) => Ulimit.fromJson(e as Map<String, dynamic>))
              .toList(),
      portBindings: (json['PortBindings'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map(
                (e) => ContainerPortBinding.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      ),
      annotations: Map<String, String>.from(json['Annotations'] as Map),
    );

Map<String, dynamic> _$ContainerHostConfigToJson(
  ContainerHostConfig instance,
) => <String, dynamic>{
  'AutoRemove': instance.autoRemove,
  'Privileged': instance.privileged,
  'PublishAllPorts': instance.publishAllPorts,
  'ReadonlyRootfs': instance.readonlyRootfs,
  'Ulimits': instance.ulimits,
  'PortBindings': instance.portBindings,
  'Annotations': instance.annotations,
};
