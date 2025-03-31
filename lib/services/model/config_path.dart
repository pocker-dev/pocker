import 'package:json_annotation/json_annotation.dart';

part 'config_path.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ConfigPath {
  ConfigPath({
    required this.path,
  });

  String path;

  factory ConfigPath.fromJson(Map<String, dynamic> json) =>
      _$ConfigPathFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigPathToJson(this);
}
