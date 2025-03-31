import 'package:json_annotation/json_annotation.dart';

part 'image_history.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageHistory {
  ImageHistory({
    required this.id,
    required this.created,
    required this.createdBy,
    this.tags,
    required this.size,
    required this.comment,
  });

  String id;
  int created;
  String createdBy;
  List<String>? tags;
  int size;
  String comment;

  factory ImageHistory.fromJson(Map<String, dynamic> json) =>
      _$ImageHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ImageHistoryToJson(this);
}
