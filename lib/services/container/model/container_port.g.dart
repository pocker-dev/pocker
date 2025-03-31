// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_port.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerPort _$ContainerPortFromJson(Map<String, dynamic> json) =>
    ContainerPort(
      hostIp: json['host_ip'] as String?,
      protocol: json['protocol'] as String?,
      containerPort: (json['container_port'] as num).toInt(),
      hostPort: (json['host_port'] as num).toInt(),
    );

Map<String, dynamic> _$ContainerPortToJson(ContainerPort instance) =>
    <String, dynamic>{
      'host_ip': instance.hostIp,
      'protocol': instance.protocol,
      'container_port': instance.containerPort,
      'host_port': instance.hostPort,
    };
