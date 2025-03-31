import 'package:json_annotation/json_annotation.dart';

import 'container_port.dart';

part 'container_summary.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerSummary {
  ContainerSummary({
    this.autoRemove,
    this.command,
    required this.created,
    this.exited,
    this.exitedAt,
    this.exitCode,
    required this.id,
    this.image,
    required this.imageID,
    this.isInfra,
    this.labels,
    required this.names,
    required this.pod,
    this.podName,
    this.restarts,
    this.startedAt,
    required this.state,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? raw;

  bool? autoRemove;
  List<String>? command;
  DateTime created;
  bool? exited;
  int? exitedAt;
  int? exitCode;

  String id;
  String? image;
  String imageID;
  bool? isInfra;
  Map<String, String>? labels;
  List<String> names;
  String pod;
  String? podName;
  List<ContainerPort>? ports;
  int? restarts;
  int? startedAt;
  String state;

  String get shortId {
    return id.substring(0, 12);
  }

  String get imageName {
    return image ?? imageID.substring(0, 12);
  }

  factory ContainerSummary.fromJson(Map<String, dynamic> json) {
    final obj = _$ContainerSummaryFromJson(json);
    obj.raw = json;
    return obj;
  }

  Map<String, dynamic> toJson() => raw ?? <String, dynamic>{};
}
