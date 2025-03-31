import 'package:json_annotation/json_annotation.dart';

part 'root_fs.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class RootFS {
  RootFS({
    required this.fsType,
    this.layers = const [],
  });

  @JsonKey(required: true, name: 'Type')
  String fsType;

  List<String> layers;

  factory RootFS.fromJson(Map<String, dynamic> json) =>
      _$RootFSFromJson(json);

  Map<String, dynamic> toJson() => _$RootFSToJson(this);
}
