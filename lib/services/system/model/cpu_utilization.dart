import 'package:json_annotation/json_annotation.dart';

part 'cpu_utilization.g.dart';

@JsonSerializable()
class CpuUtilization {
  CpuUtilization({
    required this.userPercent,
    required this.systemPercent,
    required this.idlePercent,
  });

  double userPercent;
  double systemPercent;
  double idlePercent;

  factory CpuUtilization.fromJson(Map<String, dynamic> json) =>
      _$CpuUtilizationFromJson(json);

  Map<String, dynamic> toJson() => _$CpuUtilizationToJson(this);
}
