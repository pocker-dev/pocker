import 'package:json_annotation/json_annotation.dart';

import 'pod_container_summary.dart';

part 'pod_summary.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PodSummary {
  PodSummary({
    required this.cgroup,
    required this.containers,
    required this.created,
    required this.id,
    required this.infraId,
    required this.name,
    required this.namespace,
    required this.networks,
    required this.status,
  });

  String cgroup;
  List<PodContainerSummary> containers;
  DateTime created;
  String id;
  String infraId;
  String name;
  String namespace;
  List<String> networks;
  String status;

  String get shortId {
    return id.substring(0, 8);
  }

  factory PodSummary.fromJson(Map<String, dynamic> json) =>
      _$PodSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PodSummaryToJson(this);
}
