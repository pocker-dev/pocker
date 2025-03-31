import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Event {
  Event({
    required this.type,
    required this.action,
    required this.id,
    required this.status,
    required this.time,
  });

  String type;
  String action;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'time')
  int time;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
