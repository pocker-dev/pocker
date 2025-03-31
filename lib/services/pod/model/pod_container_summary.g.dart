// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pod_container_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodContainerSummary _$PodContainerSummaryFromJson(Map<String, dynamic> json) =>
    PodContainerSummary(
      id: json['Id'] as String,
      names: json['Names'] as String,
      status: json['Status'] as String,
      restartCount: (json['RestartCount'] as num).toInt(),
    );

Map<String, dynamic> _$PodContainerSummaryToJson(
  PodContainerSummary instance,
) => <String, dynamic>{
  'Id': instance.id,
  'Names': instance.names,
  'Status': instance.status,
  'RestartCount': instance.restartCount,
};
