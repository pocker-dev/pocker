import 'package:json_annotation/json_annotation.dart';

part 'image_metadata.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageMetadata {
  ImageMetadata({required this.lastTagTime});

  /// Date and time at which the image was last tagged in RFC 3339 format with nano-seconds.
  ///
  /// This information is only available if the image was tagged locally, and omitted otherwise.
  String? lastTagTime;

  factory ImageMetadata.fromJson(Map<String, dynamic> json) =>
      _$ImageMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageMetadataToJson(this);
}
