// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pod_inspect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodInspect _$PodInspectFromJson(Map<String, dynamic> json) => PodInspect(
  id: json['Id'] as String,
  name: json['Name'] as String,
  created: DateTime.parse(json['Created'] as String),
  createCommand:
      (json['CreateCommand'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  exitPolicy: json['ExitPolicy'] as String?,
  state: json['State'] as String,
  hostname: json['Hostname'] as String?,
  createCgroup: json['CreateCgroup'] as bool?,
  cgroupParent: json['CgroupParent'] as String?,
  cgroupPath: json['CgroupPath'] as String?,
  createInfra: json['CreateInfra'] as bool?,
  numContainers: (json['NumContainers'] as num?)?.toInt(),
  containers:
      (json['Containers'] as List<dynamic>)
          .map((e) => PodContainerInspect.fromJson(e as Map<String, dynamic>))
          .toList(),
  lockNumber: (json['LockNumber'] as num?)?.toInt(),
);

Map<String, dynamic> _$PodInspectToJson(PodInspect instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Created': instance.created.toIso8601String(),
      'CreateCommand': instance.createCommand,
      'ExitPolicy': instance.exitPolicy,
      'State': instance.state,
      'Hostname': instance.hostname,
      'CreateCgroup': instance.createCgroup,
      'CgroupParent': instance.cgroupParent,
      'CgroupPath': instance.cgroupPath,
      'CreateInfra': instance.createInfra,
      'NumContainers': instance.numContainers,
      'Containers': instance.containers,
      'LockNumber': instance.lockNumber,
    };
