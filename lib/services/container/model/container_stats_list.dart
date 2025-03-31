import 'package:json_annotation/json_annotation.dart';

import 'container_stats.dart';

part 'container_stats_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerStatsList {
  ContainerStatsList({
    required this.stats,
  });

  List<ContainerStats> stats;

  factory ContainerStatsList.fromJson(Map<String, dynamic> json) =>
      _$ContainerStatsListFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerStatsListToJson(this);
}
