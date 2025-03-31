import 'package:json_annotation/json_annotation.dart';

part 'container_usage.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerUsage {
  ContainerUsage({
    required this.containerID,
    required this.image,
    this.command,
    required this.localVolumes,
    required this.size,
    required this.rWSize,
    required this.created,
    required this.status,
    required this.names,
  });

  String containerID;
  String image;
  List<String>? command;
  int localVolumes;
  int size;
  int rWSize;
  DateTime created;
  String status;
  String names;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContainerUsage &&
          runtimeType == other.runtimeType &&
          containerID == other.containerID &&
          status == other.status;

  @override
  int get hashCode => '$containerID::$status'.hashCode;

  factory ContainerUsage.fromJson(Map<String, dynamic> json) =>
      _$ContainerUsageFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerUsageToJson(this);
}
