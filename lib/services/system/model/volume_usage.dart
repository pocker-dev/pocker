import 'package:json_annotation/json_annotation.dart';

part 'volume_usage.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class VolumeUsage {
  VolumeUsage({
    required this.volumeName,
    required this.links,
    required this.size,
    required this.reclaimableSize,
  });

  String volumeName;
  int links;
  int size;
  int reclaimableSize;

  String get shortName {
    return volumeName.length > 12 ? volumeName.substring(0, 12) : volumeName;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VolumeUsage &&
          runtimeType == other.runtimeType &&
          volumeName == other.volumeName;

  @override
  int get hashCode => volumeName.hashCode;

  factory VolumeUsage.fromJson(Map<String, dynamic> json) =>
      _$VolumeUsageFromJson(json);

  Map<String, dynamic> toJson() => _$VolumeUsageToJson(this);
}
