import 'package:json_annotation/json_annotation.dart';
import 'package:pocker/services/model/config_path.dart';

part 'connection_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ConnectionInfo {
  ConnectionInfo({
    this.podmanSocket,
  });

  ConfigPath? podmanSocket;
  // ConfigPath? podmanPipe;

  factory ConnectionInfo.fromJson(Map<String, dynamic> json) =>
      _$ConnectionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionInfoToJson(this);
}
