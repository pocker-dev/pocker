import 'package:json_annotation/json_annotation.dart';

part 'image_usage.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageUsage {
  ImageUsage({
    required this.repository,
    required this.tag,
    required this.imageID,
    required this.created,
    required this.size,
    required this.sharedSize,
    required this.uniqueSize,
    required this.containers,
  });

  String repository;
  String tag;
  String imageID;
  DateTime created;
  int size;
  int sharedSize;
  int uniqueSize;
  int containers;

  String get shortId {
    return imageID.substring(0, 12);
  }

  String? get name {
    if (repository == '<none>' && tag == '<none>') {
      return null;
    }
    return '$repository:$tag';
  }

  String get displayName {
    return name ?? '<none>';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageUsage &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          containers == other.containers;

  @override
  int get hashCode => '$name::$containers'.hashCode;

  factory ImageUsage.fromJson(Map<String, dynamic> json) =>
      _$ImageUsageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUsageToJson(this);
}
