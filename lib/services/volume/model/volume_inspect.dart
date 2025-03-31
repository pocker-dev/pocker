import 'package:json_annotation/json_annotation.dart';

part 'volume_inspect.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class VolumeInspect {
  VolumeInspect({
    required this.createdAt,
    required this.driver,
    required this.labels,
    required this.mountpoint,
    required this.name,
    required this.options,
    required this.scope,
  });

  /// CreatedAt is the date and time the volume was created at. This is not stored for
  /// older Libpod volumes; if so, it will be omitted.
  String createdAt;

  /// Driver is the driver used to create the volume. If set to "local" or "", the Local driver
  /// (Podman built-in code) is used to service the volume; otherwise, a volume plugin with the
  /// given name is used to mount and manage the volume.
  String driver;

  /// Labels includes the volume's configured labels, key:value pairs that can be passed during
  /// volume creation to provide information for third party tools.
  Map<String, String> labels;

  /// Mountpoint is the path on the host where the volume is mounted.
  String mountpoint;

  /// Name is the name of the volume.
  String name;

  /// Options is a set of options that were used when creating the volume. For the Local driver,
  /// these are mount options that will be used to determine how a local filesystem is mounted;
  /// they are handled as parameters to Mount in a manner described in the volume create
  /// manpage. For non-local drivers, these are passed as-is to the volume plugin.
  Map<String, String> options;

  /// Scope is unused and provided solely for Docker compatibility. It is unconditionally set to
  /// "local".
  String scope;

  String get shortName {
    return name.length > 12 ? name.substring(0, 12) : name;
  }

  factory VolumeInspect.fromJson(Map<String, dynamic> json) =>
      _$VolumeInspectFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeInspectToJson(this);
}
