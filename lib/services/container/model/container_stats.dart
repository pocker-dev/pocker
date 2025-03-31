import 'package:json_annotation/json_annotation.dart';

part 'container_stats.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerStats {
  ContainerStats({
    required this.name,
    required this.containerID,
    required this.cPU,
    required this.avgCPU,
    required this.memUsage,
    required this.memLimit,
    required this.memPerc,
    required this.upTime,
    required this.duration,
  });

  String name;
  String containerID;
  double cPU;
  double avgCPU;
  int memUsage;
  int memLimit;
  double memPerc;
  int upTime;
  int duration;

  factory ContainerStats.fromJson(Map<String, dynamic> json) =>
      _$ContainerStatsFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerStatsToJson(this);
}
