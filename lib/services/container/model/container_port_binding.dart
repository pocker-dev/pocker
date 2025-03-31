import 'package:json_annotation/json_annotation.dart';

part 'container_port_binding.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerPortBinding {
  ContainerPortBinding({
    required this.hostIp,
    required this.hostPort,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? raw;

  String hostIp;
  String hostPort;

  factory ContainerPortBinding.fromJson(Map<String, dynamic> json) {
    final obj = _$ContainerPortBindingFromJson(json);
    obj.raw = json;
    return obj;
  }

  Map<String, dynamic> toJson() => raw ?? <String, dynamic>{};
}
