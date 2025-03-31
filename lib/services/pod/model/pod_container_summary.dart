import 'package:json_annotation/json_annotation.dart';

part 'pod_container_summary.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PodContainerSummary {
  PodContainerSummary({
    required this.id,
    required this.names,
    required this.status,
    required this.restartCount,
  });

  String id;
  String names;
  String status;
  int restartCount;

  factory PodContainerSummary.fromJson(Map<String, dynamic> json) =>
      _$PodContainerSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PodContainerSummaryToJson(this);
}
