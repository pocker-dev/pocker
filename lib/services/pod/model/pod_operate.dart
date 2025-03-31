import 'package:json_annotation/json_annotation.dart';

part 'pod_operate.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PodOperate {
  PodOperate({
    this.id,
    this.rawInput,
    this.errs,
  });

  String? id;
  String? rawInput;
  List<String>? errs;

  factory PodOperate.fromJson(Map<String, dynamic> json) =>
      _$PodOperateFromJson(json);

  Map<String, dynamic> toJson() => _$PodOperateToJson(this);
}
