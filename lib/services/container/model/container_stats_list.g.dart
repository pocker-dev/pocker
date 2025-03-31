// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_stats_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerStatsList _$ContainerStatsListFromJson(Map<String, dynamic> json) =>
    ContainerStatsList(
      stats:
          (json['Stats'] as List<dynamic>)
              .map((e) => ContainerStats.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ContainerStatsListToJson(ContainerStatsList instance) =>
    <String, dynamic>{'Stats': instance.stats};
