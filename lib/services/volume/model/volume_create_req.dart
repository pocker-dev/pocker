import 'package:json_annotation/json_annotation.dart';

part 'volume_create_req.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class VolumeCreateReq {
  VolumeCreateReq({
    required this.driver,
    required this.ignoreIfExists,
    required this.label,
    required this.labels,
    required this.name,
    required this.options,
  });

  /// Driver is the driver used to create the volume. If set to "local" or "", the Local driver
  /// (Podman built-in code) is used to service the volume; otherwise, a volume plugin with the
  /// given name is used to mount and manage the volume.
  String driver;

  /// Ignore existing volumes.
  bool ignoreIfExists;

  /// User-defined key/value metadata. Provided for compatibility.
  Map<String, String> label;

  /// User-defined key/value metadata. Preferred field, will override Label.
  Map<String, String> labels;

  /// New volume's name. Can be left blank.
  String name;

  /// Mapping of driver options and values.
  Map<String, String> options;

  factory VolumeCreateReq.fromJson(Map<String, dynamic> json) =>
      _$VolumeCreateReqFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeCreateReqToJson(this);
}
