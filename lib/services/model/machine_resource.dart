import 'package:json_annotation/json_annotation.dart';

part 'machine_resource.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MachineResource {
  MachineResource({
    required this.cPUs,
    required this.diskSize,
    required this.memory,
    this.uSBs,
  });

  int cPUs;
  int diskSize;
  int memory;
  List<String>? uSBs;

  factory MachineResource.fromJson(Map<String, dynamic> json) =>
      _$MachineResourceFromJson(json);

  Map<String, dynamic> toJson() => _$MachineResourceToJson(this);
}
