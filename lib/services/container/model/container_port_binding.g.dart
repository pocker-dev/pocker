// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_port_binding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerPortBinding _$ContainerPortBindingFromJson(
  Map<String, dynamic> json,
) => ContainerPortBinding(
  hostIp: json['HostIp'] as String,
  hostPort: json['HostPort'] as String,
);

Map<String, dynamic> _$ContainerPortBindingToJson(
  ContainerPortBinding instance,
) => <String, dynamic>{
  'HostIp': instance.hostIp,
  'HostPort': instance.hostPort,
};
