import 'package:json_annotation/json_annotation.dart';

part 'image_removed.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageRemoved {
  ImageRemoved({
    this.deleted,
    this.errors,
    this.exitCode,
    this.untagged,
  });

  /// Deleted images.
  List<String>? deleted;

  /// Image removal requires is to return data and an error.
  List<String>? errors;

  /// ExitCode describes the exit codes as described in the podman rmi man page.
  int? exitCode;

  /// Untagged images. Can be longer than Deleted.
  List<String>? untagged;

  factory ImageRemoved.fromJson(Map<String, dynamic> json) =>
      _$ImageRemovedFromJson(json);

  Map<String, dynamic> toJson() => _$ImageRemovedToJson(this);
}
