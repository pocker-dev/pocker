// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerConfig _$ContainerConfigFromJson(Map<String, dynamic> json) =>
    ContainerConfig(
      hostname: json['Hostname'] as String,
      attachStdin: json['AttachStdin'] as bool?,
      attachStdout: json['AttachStdout'] as bool?,
      attachStderr: json['AttachStderr'] as bool?,
      tty: json['Tty'] as bool?,
      openStdin: json['OpenStdin'] as bool?,
      stdinOnce: json['StdinOnce'] as bool?,
      env: (json['Env'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cmd: (json['Cmd'] as List<dynamic>?)?.map((e) => e as String).toList(),
      image: json['Image'] as String?,
      workingDir: json['WorkingDir'] as String?,
      labels: (json['Labels'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      stopSignal: json['StopSignal'] as String?,
      stopTimeout: (json['StopTimeout'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContainerConfigToJson(ContainerConfig instance) =>
    <String, dynamic>{
      'Hostname': instance.hostname,
      'AttachStdin': instance.attachStdin,
      'AttachStdout': instance.attachStdout,
      'AttachStderr': instance.attachStderr,
      'Tty': instance.tty,
      'OpenStdin': instance.openStdin,
      'StdinOnce': instance.stdinOnce,
      'Env': instance.env,
      'Cmd': instance.cmd,
      'Image': instance.image,
      'WorkingDir': instance.workingDir,
      'Labels': instance.labels,
      'StopSignal': instance.stopSignal,
      'StopTimeout': instance.stopTimeout,
    };
