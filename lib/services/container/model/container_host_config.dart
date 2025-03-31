import 'package:json_annotation/json_annotation.dart';
import 'package:pocker/services/model/ulimit.dart';

import 'container_port_binding.dart';

part 'container_host_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerHostConfig {
  ContainerHostConfig({
    this.autoRemove,
    this.privileged,
    this.publishAllPorts,
    this.readonlyRootfs,
    required this.ulimits,
    required this.portBindings,
    required this.annotations,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? raw;

  bool? autoRemove;
  bool? privileged;
  bool? publishAllPorts;
  bool? readonlyRootfs;
  List<Ulimit> ulimits;
  Map<String, List<ContainerPortBinding>> portBindings;
  Map<String, String> annotations;

  factory ContainerHostConfig.fromJson(Map<String, dynamic> json) {
    final obj = _$ContainerHostConfigFromJson(json);
    obj.raw = json;
    return obj;
  }

  Map<String, dynamic> toJson() => raw ?? <String, dynamic>{};
}
