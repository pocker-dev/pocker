// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Host _$HostFromJson(Map<String, dynamic> json) => Host(
  cpus: (json['cpus'] as num).toInt(),
  cpuUtilization: CpuUtilization.fromJson(
    json['cpuUtilization'] as Map<String, dynamic>,
  ),
  memFree: (json['memFree'] as num).toInt(),
  memTotal: (json['memTotal'] as num).toInt(),
);

Map<String, dynamic> _$HostToJson(Host instance) => <String, dynamic>{
  'cpus': instance.cpus,
  'cpuUtilization': instance.cpuUtilization,
  'memFree': instance.memFree,
  'memTotal': instance.memTotal,
};
