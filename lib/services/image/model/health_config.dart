import 'package:json_annotation/json_annotation.dart';

part 'health_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class HealthConfig {
  HealthConfig({
    required this.test,
    required this.interval,
    required this.timeout,
    required this.reties,
    required this.startPeriod,
  });

  /// The test to perform. Possible values are:
  ///
  /// * [] inherit healthcheck from image or parent image
  /// * ["NONE"] disable healthcheck
  /// * ["CMD", args...] exec arguments directly
  /// * ["CMD-SHELL", command] run command with system's default shell
  String test;

  /// The time to wait between checks in nanoseconds.
  /// It should be 0 or at least 1000000 (1 ms). 0 means inherit.
  int interval;

  /// The time to wait before considering the check to have hung.
  /// It should be 0 or at least 1000000 (1 ms). 0 means inherit.
  int timeout;

  /// The number of consecutive failures needed to consider a container as unhealthy.
  /// 0 means inherit.
  int reties;

  /// Start period for the container to initialize before starting health-retries
  /// countdown in nanoseconds. It should be 0 or at least 1000000 (1 ms).
  /// 0 means inherit.
  int startPeriod;

  factory HealthConfig.fromJson(Map<String, dynamic> json) =>
      _$HealthConfigFromJson(json);

  Map<String, dynamic> toJson() => _$HealthConfigToJson(this);
}
