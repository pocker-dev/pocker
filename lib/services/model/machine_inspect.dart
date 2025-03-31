import 'package:json_annotation/json_annotation.dart';
import 'package:pocker/services/model/config_path.dart';
import 'package:pocker/services/model/machine_resource.dart';

import 'connection_info.dart';
import 'ssh_config.dart';

part 'machine_inspect.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MachineInspect {
  MachineInspect({
    this.configDir,
    this.connectionInfo,
    this.created,
    this.lastUp,
    this.name,
    this.state,
    this.resources,
    this.sSHConfig,
    this.userModeNetworking,
    this.rootful,
    this.rosetta,
  });

  ConfigPath? configDir;
  ConnectionInfo? connectionInfo;

  DateTime? created;
  DateTime? lastUp;

  String? name;
  String? state;

  MachineResource? resources;
  SSHConfig? sSHConfig;

  bool? userModeNetworking;
  bool? rootful;
  bool? rosetta;

  factory MachineInspect.fromJson(Map<String, dynamic> json) =>
      _$MachineInspectFromJson(json);

  Map<String, dynamic> toJson() => _$MachineInspectToJson(this);
}
