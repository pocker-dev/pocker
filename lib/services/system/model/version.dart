import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Version {
  Version({
    required this.version,
    this.apiVersion,
    required this.os,
    required this.osArch,
  });

  String version;
  String? apiVersion;

  String os;
  String osArch;

  factory Version.fromJson(Map<String, dynamic> json) =>
      _$VersionFromJson(json);

  Map<String, dynamic> toJson() => _$VersionToJson(this);
}
