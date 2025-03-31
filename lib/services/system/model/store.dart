import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable()
class Store {
  Store({
    required this.graphRootUsed,
    required this.graphRootAllocated,
  });

  int graphRootUsed;
  int graphRootAllocated;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
