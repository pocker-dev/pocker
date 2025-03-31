// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerStats _$ContainerStatsFromJson(Map<String, dynamic> json) =>
    ContainerStats(
      name: json['Name'] as String,
      containerID: json['ContainerID'] as String,
      cPU: (json['CPU'] as num).toDouble(),
      avgCPU: (json['AvgCPU'] as num).toDouble(),
      memUsage: (json['MemUsage'] as num).toInt(),
      memLimit: (json['MemLimit'] as num).toInt(),
      memPerc: (json['MemPerc'] as num).toDouble(),
      upTime: (json['UpTime'] as num).toInt(),
      duration: (json['Duration'] as num).toInt(),
    );

Map<String, dynamic> _$ContainerStatsToJson(ContainerStats instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'ContainerID': instance.containerID,
      'CPU': instance.cPU,
      'AvgCPU': instance.avgCPU,
      'MemUsage': instance.memUsage,
      'MemLimit': instance.memLimit,
      'MemPerc': instance.memPerc,
      'UpTime': instance.upTime,
      'Duration': instance.duration,
    };
