// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cpu_utilization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CpuUtilization _$CpuUtilizationFromJson(Map<String, dynamic> json) =>
    CpuUtilization(
      userPercent: (json['userPercent'] as num).toDouble(),
      systemPercent: (json['systemPercent'] as num).toDouble(),
      idlePercent: (json['idlePercent'] as num).toDouble(),
    );

Map<String, dynamic> _$CpuUtilizationToJson(CpuUtilization instance) =>
    <String, dynamic>{
      'userPercent': instance.userPercent,
      'systemPercent': instance.systemPercent,
      'idlePercent': instance.idlePercent,
    };
