// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssh_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSHConfig _$SSHConfigFromJson(Map<String, dynamic> json) => SSHConfig(
  identityPath: json['IdentityPath'] as String,
  remoteUsername: json['RemoteUsername'] as String,
  port: (json['Port'] as num).toInt(),
);

Map<String, dynamic> _$SSHConfigToJson(SSHConfig instance) => <String, dynamic>{
  'IdentityPath': instance.identityPath,
  'RemoteUsername': instance.remoteUsername,
  'Port': instance.port,
};
