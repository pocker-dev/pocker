import 'package:json_annotation/json_annotation.dart';

part 'pruned_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PrunedResponse {
  PrunedResponse({
    this.err,
    this.id,
    this.size,
  });

  String? err;
  String? id;
  int? size;

  factory PrunedResponse.fromJson(Map<String, dynamic> json) =>
      _$PrunedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrunedResponseToJson(this);
}
