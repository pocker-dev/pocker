import 'package:json_annotation/json_annotation.dart';

part 'pod_container_inspect.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PodContainerInspect {
  PodContainerInspect({
    required this.id,
    required this.name,
    required this.state,
  });

  String id;
  String name;
  String state;

  factory PodContainerInspect.fromJson(Map<String, dynamic> json) =>
      _$PodContainerInspectFromJson(json);

  Map<String, dynamic> toJson() => _$PodContainerInspectToJson(this);
}
