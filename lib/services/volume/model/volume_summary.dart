import 'package:json_annotation/json_annotation.dart';

part 'volume_summary.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class VolumeSummary {
  VolumeSummary({
    this.anonymous,
    required this.createdAt,
    required this.driver,
    required this.mountCount,
    required this.mountpoint,
    required this.name,
  });

  /// Anonymous indicates that the volume was created as an anonymous volume for a
  /// specific container, and will be removed when any container using it is removed.
  bool? anonymous;

  /// CreatedAt is the date and time the volume was created at. This is not stored for
  /// older Libpod volumes; if so, it will be omitted.
  DateTime createdAt;

  /// Driver is the driver used to create the volume. If set to "local" or "", the Local driver
  /// (Podman built-in code) is used to service the volume; otherwise, a volume plugin with the
  /// given name is used to mount and manage the volume.
  String driver;

  /// MountCount is the number of times this volume has been mounted.
  int mountCount;

  /// Mountpoint is the path on the host where the volume is mounted.
  String mountpoint;

  /// Name is the name of the volume.
  String name;

  String get shortName {
    return name.length > 12 ? name.substring(0, 12) : name;
  }

  factory VolumeSummary.fromJson(Map<String, dynamic> json) =>
      _$VolumeSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeSummaryToJson(this);
}
