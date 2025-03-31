import 'package:json_annotation/json_annotation.dart';

part 'volume_create_resp.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class VolumeCreateResp {
  VolumeCreateResp({
    this.anonymous,
    this.createdAt,
    this.driver,
    this.mountCount,
    this.mountpoint,
    required this.name,
    this.scope,
    this.timeout,
  });

  /// Anonymous indicates that the volume was created as an anonymous volume for a
  /// specific container, and will be removed when any container using it is removed.
  bool? anonymous;

  /// CreatedAt is the date and time the volume was created at. This is not stored for
  /// older Libpod volumes; if so, it will be omitted.
  String? createdAt;

  /// Driver is the driver used to create the volume. If set to "local" or "", the Local driver
  /// (Podman built-in code) is used to service the volume; otherwise, a volume plugin with the
  /// given name is used to mount and manage the volume.
  String? driver;

  /// MountCount is the number of times this volume has been mounted.
  int? mountCount;

  /// Mountpoint is the path on the host where the volume is mounted.
  String? mountpoint;

  /// Name is the name of the volume.
  String name;

  /// Scope is unused and provided solely for Docker compatibility. It is unconditionally set to
  /// "local".
  String? scope;

  /// Timeout is the specified driver timeout if given.
  int? timeout;

  factory VolumeCreateResp.fromJson(Map<String, dynamic> json) =>
      _$VolumeCreateRespFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeCreateRespToJson(this);
}
