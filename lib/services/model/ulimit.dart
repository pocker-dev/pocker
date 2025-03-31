import 'package:json_annotation/json_annotation.dart';

part 'ulimit.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Ulimit {
  Ulimit({
    required this.name,
    required this.hard,
    required this.soft,
  });

  String name;
  int hard;
  int soft;

  factory Ulimit.fromJson(Map<String, dynamic> json) => _$UlimitFromJson(json);

  Map<String, dynamic> toJson() => _$UlimitToJson(this);
}
