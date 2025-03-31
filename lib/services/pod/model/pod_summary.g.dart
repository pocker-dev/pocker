// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pod_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodSummary _$PodSummaryFromJson(Map<String, dynamic> json) => PodSummary(
  cgroup: json['Cgroup'] as String,
  containers:
      (json['Containers'] as List<dynamic>)
          .map((e) => PodContainerSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
  created: DateTime.parse(json['Created'] as String),
  id: json['Id'] as String,
  infraId: json['InfraId'] as String,
  name: json['Name'] as String,
  namespace: json['Namespace'] as String,
  networks:
      (json['Networks'] as List<dynamic>).map((e) => e as String).toList(),
  status: json['Status'] as String,
);

Map<String, dynamic> _$PodSummaryToJson(PodSummary instance) =>
    <String, dynamic>{
      'Cgroup': instance.cgroup,
      'Containers': instance.containers,
      'Created': instance.created.toIso8601String(),
      'Id': instance.id,
      'InfraId': instance.infraId,
      'Name': instance.name,
      'Namespace': instance.namespace,
      'Networks': instance.networks,
      'Status': instance.status,
    };
