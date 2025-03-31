import 'package:json_annotation/json_annotation.dart';

part 'image_summary.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageSummary {
  ImageSummary({
    required this.arch,
    required this.containers,
    required this.created,
    required this.digest,
    required this.id,
    this.names,
    required this.os,
    required this.size,
    required this.sharedSize,
    required this.virtualSize,
  });

  String arch;
  int containers;
  int created;
  String digest;
  String id;
  List<String>? names;
  String os;
  int size;
  int sharedSize;
  int virtualSize;

  String get shortId {
    return id.substring(0, 12);
  }

  factory ImageSummary.fromJson(Map<String, dynamic> json) =>
      _$ImageSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$ImageSummaryToJson(this);
}
