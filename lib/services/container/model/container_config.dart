import 'package:json_annotation/json_annotation.dart';

part 'container_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerConfig {
  ContainerConfig({
    required this.hostname,
    this.attachStdin,
    this.attachStdout,
    this.attachStderr,
    this.tty,
    this.openStdin,
    this.stdinOnce,
    this.env,
    this.cmd,
    this.image,
    this.workingDir,
    this.labels,
    this.stopSignal,
    this.stopTimeout,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? raw;

  String hostname;
  bool? attachStdin;
  bool? attachStdout;
  bool? attachStderr;
  bool? tty;
  bool? openStdin;
  bool? stdinOnce;
  List<String>? env;
  List<String>? cmd;
  String? image;
  String? workingDir;
  Map<String, String>? labels;
  String? stopSignal;
  int? stopTimeout;

  factory ContainerConfig.fromJson(Map<String, dynamic> json) {
    final obj = _$ContainerConfigFromJson(json);
    obj.raw = json;
    return obj;
  }

  Map<String, dynamic> toJson() => raw ?? <String, dynamic>{};
}
