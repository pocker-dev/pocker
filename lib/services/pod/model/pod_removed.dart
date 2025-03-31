import 'package:json_annotation/json_annotation.dart';

part 'pod_removed.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PodRemoved {
  PodRemoved({
    this.id,
    this.err,
  });

  String? id;
  String? err;
  Map<String, Object?>? removedCtrs;

  factory PodRemoved.fromJson(Map<String, dynamic> json) =>
      _$PodRemovedFromJson(json);

  Map<String, dynamic> toJson() => _$PodRemovedToJson(this);
}
