import 'package:json_annotation/json_annotation.dart';

import 'cpu_utilization.dart';

part 'host.g.dart';

@JsonSerializable()
class Host {
  Host({
    required this.cpus,
    required this.cpuUtilization,
    required this.memFree,
    required this.memTotal,
  });

  int cpus;
  CpuUtilization cpuUtilization;

  int memFree;
  int memTotal;

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

  Map<String, dynamic> toJson() => _$HostToJson(this);
}
