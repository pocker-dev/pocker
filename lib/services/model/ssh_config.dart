import 'package:json_annotation/json_annotation.dart';

part 'ssh_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SSHConfig {
  SSHConfig({
    required this.identityPath,
    required this.remoteUsername,
    required this.port,
  });

  String identityPath;
  String remoteUsername;
  int port;

  factory SSHConfig.fromJson(Map<String, dynamic> json) =>
      _$SSHConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SSHConfigToJson(this);
}
