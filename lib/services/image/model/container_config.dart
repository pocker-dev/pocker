import 'package:json_annotation/json_annotation.dart';

import 'health_config.dart';

part 'container_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ContainerConfig {
  ContainerConfig({
    required this.hostname,
    required this.domainname,
    required this.user,
    required this.attachStdin,
    required this.attachStdout,
    required this.attachStderr,
    this.exposedPorts,
    required this.tty,
    required this.openStdin,
    required this.stdinOnce,
    this.env,
    this.cmd,
    this.healthcheck,
    this.argsEscaped,
    required this.image,
    this.volumes,
    required this.workingDir,
    this.entrypoint,
    this.networkDisabled,
    this.macAddress,
    this.onBuild,
    this.labels,
    this.stopSignal,
    this.stopTimeout,
    this.shell,
  });

  /// The hostname to use for the container, as a valid RFC 1123 hostname.
  String hostname;

  /// The domain name to use for the container.
  String domainname;

  /// The user that commands are run as inside the container.
  String user;

  /// Whether to attach to stdin.
  bool attachStdin;

  /// Whether to attach to stdout.
  bool attachStdout;

  /// Whether to attach to stderr.
  bool attachStderr;

  /// An object mapping ports to an empty object in the form:
  /// {"<port>/<tcp|udp|sctp>": {}}
  Map<String, Object>? exposedPorts;

  /// Attach standard streams to a TTY, including stdin if it is not closed.
  bool tty;

  /// Open stdin
  bool openStdin;

  /// Close stdin after one attached client disconnects.
  bool stdinOnce;

  /// A list of environment variables to set inside the container
  /// in the form ["VAR=value", ...].
  /// A variable without = is removed from the environment,
  /// rather than to have an empty value.
  List<String>? env;

  /// Command to run specified as a string or an array of strings.
  List<String>? cmd;

  /// A test to perform to check that the container is healthy.
  HealthConfig? healthcheck;

  /// Command is already escaped (Windows only)
  bool? argsEscaped;

  /// The name (or reference) of the image to use when creating the container,
  /// or which was used when the container was created.
  String image;

  /// An object mapping mount point paths inside the container to empty objects.
  Map<String, Object>? volumes;

  /// The working directory for commands to run in.
  String workingDir;

  /// The entry point for the container as a string or an array of strings.
  ///
  /// If the array consists of exactly one empty string ([""]) then the entry point
  /// is reset to system default (i.e., the entry point used by docker when
  /// there is no ENTRYPOINT instruction in the Dockerfile).
  List<String>? entrypoint;

  /// Disable networking for the container.
  ///
  /// Note: this field is always omitted and must not be used.
  bool? networkDisabled;

  /// MAC address of the container.
  ///
  /// Note: this field is always omitted and must not be used.
  String? macAddress;

  /// ONBUILD metadata that were defined in the image's Dockerfile.
  List<String>? onBuild;

  /// User-defined key/value metadata.
  Map<String, String>? labels;

  /// Signal to stop a container as a string or unsigned integer.
  String? stopSignal;

  /// Timeout to stop a container in seconds.
  int? stopTimeout;

  /// Shell for when RUN, CMD, and ENTRYPOINT uses a shell.
  List<String>? shell;

  factory ContainerConfig.fromJson(Map<String, dynamic> json) =>
      _$ContainerConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerConfigToJson(this);
}
