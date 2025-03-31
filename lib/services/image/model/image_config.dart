import 'package:json_annotation/json_annotation.dart';

import 'health_config.dart';

part 'image_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageConfig {
  ImageConfig({
    this.hostname,
    this.domainname,
    this.user,
    this.attachStdin,
    this.attachStdout,
    this.attachStderr,
    this.exposedPorts,
    this.tty,
    this.openStdin,
    this.stdinOnce,
    this.env,
    this.cmd,
    this.healthcheck,
    this.argsEscaped,
    this.image,
    this.volumes,
    this.workingDir,
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
  ///
  /// Note: this field is always empty and must not be used.
  String? hostname;

  /// The domain name to use for the container.
  ///
  /// Note: this field is always empty and must not be used.
  String? domainname;

  /// The user that commands are run as inside the container.
  String? user;

  /// Whether to attach to stdin.
  ///
  /// Note: this field is always false and must not be used.
  bool? attachStdin;

  /// Whether to attach to stdout.
  ///
  /// Note: this field is always false and must not be used.
  bool? attachStdout;

  /// Whether to attach to stderr.
  ///
  /// Note: this field is always false and must not be used.
  bool? attachStderr;

  /// An object mapping ports to an empty object in the form:
  /// {"<port>/<tcp|udp|sctp>": {}}
  Map<String, Object>? exposedPorts;

  /// Attach standard streams to a TTY, including stdin if it is not closed.
  ///
  /// Note: this field is always false and must not be used.
  bool? tty;

  /// Open stdin
  ///
  /// Note: this field is always false and must not be used.
  bool? openStdin;

  /// Close stdin after one attached client disconnects.
  ///
  /// Note: this field is always false and must not be used.
  bool? stdinOnce;

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
  ///
  /// Note: this field is always empty and must not be used.
  String? image;

  /// An object mapping mount point paths inside the container to empty objects.
  Map<String, Object>? volumes;

  /// The working directory for commands to run in.
  String? workingDir;

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
  ///
  /// Note: this field is always omitted and must not be used.
  int? stopTimeout;

  /// Shell for when RUN, CMD, and ENTRYPOINT uses a shell.
  List<String>? shell;

  factory ImageConfig.fromJson(Map<String, dynamic> json) =>
      _$ImageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ImageConfigToJson(this);
}
