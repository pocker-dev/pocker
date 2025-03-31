import 'package:json_annotation/json_annotation.dart';

part 'image_pull_progress.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class ImagePulledProgress {
  ImagePulledProgress({
    this.id,
    this.stream,
    this.error,
    this.images,
  });

  String? id;
  String? stream;
  String? error;
  List<String>? images;

  factory ImagePulledProgress.fromJson(Map<String, dynamic> json) =>
      _$ImagePulledProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePulledProgressToJson(this);
}
