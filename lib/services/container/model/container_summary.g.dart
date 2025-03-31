// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerSummary _$ContainerSummaryFromJson(
  Map<String, dynamic> json,
) => ContainerSummary(
    autoRemove: json['AutoRemove'] as bool?,
    command:
        (json['Command'] as List<dynamic>?)?.map((e) => e as String).toList(),
    created: DateTime.parse(json['Created'] as String),
    exited: json['Exited'] as bool?,
    exitedAt: (json['ExitedAt'] as num?)?.toInt(),
    exitCode: (json['ExitCode'] as num?)?.toInt(),
    id: json['Id'] as String,
    image: json['Image'] as String?,
    imageID: json['ImageID'] as String,
    isInfra: json['IsInfra'] as bool?,
    labels: (json['Labels'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    names: (json['Names'] as List<dynamic>).map((e) => e as String).toList(),
    pod: json['Pod'] as String,
    podName: json['PodName'] as String?,
    restarts: (json['Restarts'] as num?)?.toInt(),
    startedAt: (json['StartedAt'] as num?)?.toInt(),
    state: json['State'] as String,
  )
  ..ports =
      (json['Ports'] as List<dynamic>?)
          ?.map((e) => ContainerPort.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ContainerSummaryToJson(ContainerSummary instance) =>
    <String, dynamic>{
      'AutoRemove': instance.autoRemove,
      'Command': instance.command,
      'Created': instance.created.toIso8601String(),
      'Exited': instance.exited,
      'ExitedAt': instance.exitedAt,
      'ExitCode': instance.exitCode,
      'Id': instance.id,
      'Image': instance.image,
      'ImageID': instance.imageID,
      'IsInfra': instance.isInfra,
      'Labels': instance.labels,
      'Names': instance.names,
      'Pod': instance.pod,
      'PodName': instance.podName,
      'Ports': instance.ports,
      'Restarts': instance.restarts,
      'StartedAt': instance.startedAt,
      'State': instance.state,
    };
