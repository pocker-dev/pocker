// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerState _$ContainerStateFromJson(Map<String, dynamic> json) =>
    ContainerState(
      status: json['Status'] as String,
      running: json['Running'] as bool,
      paused: json['Paused'] as bool,
      restarting: json['Restarting'] as bool,
      oOMKilled: json['OOMKilled'] as bool,
      dead: json['Dead'] as bool,
      pid: (json['Pid'] as num?)?.toInt(),
      exitCode: (json['ExitCode'] as num?)?.toInt(),
      error: json['Error'] as String?,
      startedAt:
          json['StartedAt'] == null
              ? null
              : DateTime.parse(json['StartedAt'] as String),
      finishedAt:
          json['FinishedAt'] == null
              ? null
              : DateTime.parse(json['FinishedAt'] as String),
    );

Map<String, dynamic> _$ContainerStateToJson(ContainerState instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Running': instance.running,
      'Paused': instance.paused,
      'Restarting': instance.restarting,
      'OOMKilled': instance.oOMKilled,
      'Dead': instance.dead,
      'Pid': instance.pid,
      'ExitCode': instance.exitCode,
      'Error': instance.error,
      'StartedAt': instance.startedAt?.toIso8601String(),
      'FinishedAt': instance.finishedAt?.toIso8601String(),
    };
