import 'package:json_annotation/json_annotation.dart';

import 'container_config.dart';
import 'container_host_config.dart';
import 'container_state.dart';

part 'container_inspect.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerInspect {
  ContainerInspect({
    required this.id,
    this.created,
    this.args,
    required this.state,
    required this.image,
    required this.name,
    this.restartCount,
    this.platform,
    required this.hostConfig,
    this.mounts,
    required this.config,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? raw;

  String id;
  DateTime? created;
  List<String>? args;
  ContainerState state;
  String image;
  String name;
  int? restartCount;
  String? platform;
  ContainerHostConfig hostConfig;
  List<Object>? mounts;
  ContainerConfig config;

  String get ports {
    if (hostConfig.portBindings.isEmpty) {
      return 'N/A';
    }
    final List<String> ports = [];
    for (final binding in hostConfig.portBindings.values) {
      final port = binding.firstOrNull?.hostPort;
      if (port != null && port != '') {
        ports.add(port);
      }
    }
    return ports.isEmpty ? 'N/A' : ports.join(', ');
  }

  String get groupName {
    if (isStandalone) {
      return name.substring(1);
    }
    if (isCompose && config.labels != null) {
      for (final entry in config.labels!.entries) {
        if (entry.key.toLowerCase() == 'com.docker.compose.project') {
          return entry.value;
        }
      }
    }
    return config.hostname;
  }

  String get groupType {
    if (isStandalone) {
      return 'standalone';
    }
    if (isCompose) {
      return 'compose';
    }
    return 'pod';
  }

  bool get isStandalone {
    if (name.endsWith('-infra')) {
      return false;
    }
    final sandboxId = hostConfig.annotations['io.kubernetes.cri-o.SandboxID'];
    if (sandboxId == null) {
      return true;
    }
    return false;
  }

  bool get isCompose {
    if (config.labels == null) {
      return false;
    }
    for (final key in config.labels!.keys) {
      if (key.toLowerCase().startsWith('com.docker.compose')) {
        return true;
      }
    }
    return false;
  }

  factory ContainerInspect.fromJson(Map<String, dynamic> json) {
    final obj = _$ContainerInspectFromJson(json);
    obj.raw = json;
    return obj;
  }

  Map<String, dynamic> toJson() => raw ?? <String, dynamic>{};
}
