// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageConfig _$ImageConfigFromJson(Map<String, dynamic> json) => ImageConfig(
  hostname: json['Hostname'] as String?,
  domainname: json['Domainname'] as String?,
  user: json['User'] as String?,
  attachStdin: json['AttachStdin'] as bool?,
  attachStdout: json['AttachStdout'] as bool?,
  attachStderr: json['AttachStderr'] as bool?,
  exposedPorts: (json['ExposedPorts'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as Object),
  ),
  tty: json['Tty'] as bool?,
  openStdin: json['OpenStdin'] as bool?,
  stdinOnce: json['StdinOnce'] as bool?,
  env: (json['Env'] as List<dynamic>?)?.map((e) => e as String).toList(),
  cmd: (json['Cmd'] as List<dynamic>?)?.map((e) => e as String).toList(),
  healthcheck:
      json['Healthcheck'] == null
          ? null
          : HealthConfig.fromJson(json['Healthcheck'] as Map<String, dynamic>),
  argsEscaped: json['ArgsEscaped'] as bool?,
  image: json['Image'] as String?,
  volumes: (json['Volumes'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as Object),
  ),
  workingDir: json['WorkingDir'] as String?,
  entrypoint:
      (json['Entrypoint'] as List<dynamic>?)?.map((e) => e as String).toList(),
  networkDisabled: json['NetworkDisabled'] as bool?,
  macAddress: json['MacAddress'] as String?,
  onBuild:
      (json['OnBuild'] as List<dynamic>?)?.map((e) => e as String).toList(),
  labels: (json['Labels'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  stopSignal: json['StopSignal'] as String?,
  stopTimeout: (json['StopTimeout'] as num?)?.toInt(),
  shell: (json['Shell'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ImageConfigToJson(ImageConfig instance) =>
    <String, dynamic>{
      'Hostname': instance.hostname,
      'Domainname': instance.domainname,
      'User': instance.user,
      'AttachStdin': instance.attachStdin,
      'AttachStdout': instance.attachStdout,
      'AttachStderr': instance.attachStderr,
      'ExposedPorts': instance.exposedPorts,
      'Tty': instance.tty,
      'OpenStdin': instance.openStdin,
      'StdinOnce': instance.stdinOnce,
      'Env': instance.env,
      'Cmd': instance.cmd,
      'Healthcheck': instance.healthcheck,
      'ArgsEscaped': instance.argsEscaped,
      'Image': instance.image,
      'Volumes': instance.volumes,
      'WorkingDir': instance.workingDir,
      'Entrypoint': instance.entrypoint,
      'NetworkDisabled': instance.networkDisabled,
      'MacAddress': instance.macAddress,
      'OnBuild': instance.onBuild,
      'Labels': instance.labels,
      'StopSignal': instance.stopSignal,
      'StopTimeout': instance.stopTimeout,
      'Shell': instance.shell,
    };
