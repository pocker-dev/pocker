import 'package:json_annotation/json_annotation.dart';

part 'image_build_progress.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ImageBuildProgress {
  ImageBuildProgress({
    this.stream,
    this.error,
  });

  String? stream;
  String? error;

  factory ImageBuildProgress.fromJson(Map<String, dynamic> json) =>
      _$ImageBuildProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ImageBuildProgressToJson(this);
}
