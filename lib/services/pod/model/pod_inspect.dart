import 'package:json_annotation/json_annotation.dart';

import 'pod_container_inspect.dart';

part 'pod_inspect.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PodInspect {
  PodInspect({
    required this.id,
    required this.name,
    required this.created,
    this.createCommand,
    this.exitPolicy,
    required this.state,
    this.hostname,
    this.createCgroup,
    this.cgroupParent,
    this.cgroupPath,
    this.createInfra,
    this.numContainers,
    required this.containers,
    this.lockNumber,
  });

  String id;
  String name;
  DateTime created;
  List<String>? createCommand;
  String? exitPolicy;
  String state;
  String? hostname;

  bool? createCgroup;
  String? cgroupParent;
  String? cgroupPath;
  bool? createInfra;
  int? numContainers;

  List<PodContainerInspect> containers;
  int? lockNumber;

  String get shortId {
    return id.substring(0, 8);
  }

  factory PodInspect.fromJson(Map<String, dynamic> json) =>
      _$PodInspectFromJson(json);

  Map<String, dynamic> toJson() => _$PodInspectToJson(this);
}
