import 'package:json_annotation/json_annotation.dart';

part 'container_port.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ContainerPort {
  ContainerPort({
    this.hostIp,
    this.protocol,
    required this.containerPort,
    required this.hostPort,
  });

  String? hostIp;
  String? protocol;
  int containerPort;
  int hostPort;

  factory ContainerPort.fromJson(Map<String, dynamic> json) =>
      _$ContainerPortFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerPortToJson(this);
}
