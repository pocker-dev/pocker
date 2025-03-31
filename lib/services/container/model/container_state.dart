import 'package:json_annotation/json_annotation.dart';

part 'container_state.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerState {
  ContainerState({
    required this.status,
    required this.running,
    required this.paused,
    required this.restarting,
    required this.oOMKilled,
    required this.dead,
    this.pid,
    this.exitCode,
    this.error,
    this.startedAt,
    this.finishedAt,
  });

  String status;
  bool running;
  bool paused;
  bool restarting;
  bool oOMKilled;
  bool dead;
  int? pid;
  int? exitCode;
  String? error;
  DateTime? startedAt;
  DateTime? finishedAt;

  factory ContainerState.fromJson(Map<String, dynamic> json) =>
      _$ContainerStateFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerStateToJson(this);
}
