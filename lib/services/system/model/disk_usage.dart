import 'package:json_annotation/json_annotation.dart';

import 'container_usage.dart';
import 'image_usage.dart';
import 'volume_usage.dart';

part 'disk_usage.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class DiskUsage {
  DiskUsage({
    required this.containers,
    required this.images,
    required this.volumes,
    required this.imagesSize,
  });

  List<ContainerUsage> containers;
  List<ImageUsage> images;
  List<VolumeUsage> volumes;
  int imagesSize;

  factory DiskUsage.fromJson(Map<String, dynamic> json) =>
      _$DiskUsageFromJson(json);

  Map<String, dynamic> toJson() => _$DiskUsageToJson(this);
}
