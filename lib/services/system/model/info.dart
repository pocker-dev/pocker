import 'package:json_annotation/json_annotation.dart';

import 'host.dart';
import 'store.dart';
import 'version.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
  Info({
    required this.host,
    required this.store,
    required this.version,
  });

  Host host;
  Store store;
  Version version;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
