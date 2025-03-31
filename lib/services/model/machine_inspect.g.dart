// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_inspect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineInspect _$MachineInspectFromJson(
  Map<String, dynamic> json,
) => MachineInspect(
  configDir:
      json['ConfigDir'] == null
          ? null
          : ConfigPath.fromJson(json['ConfigDir'] as Map<String, dynamic>),
  connectionInfo:
      json['ConnectionInfo'] == null
          ? null
          : ConnectionInfo.fromJson(
            json['ConnectionInfo'] as Map<String, dynamic>,
          ),
  created:
      json['Created'] == null
          ? null
          : DateTime.parse(json['Created'] as String),
  lastUp:
      json['LastUp'] == null ? null : DateTime.parse(json['LastUp'] as String),
  name: json['Name'] as String?,
  state: json['State'] as String?,
  resources:
      json['Resources'] == null
          ? null
          : MachineResource.fromJson(json['Resources'] as Map<String, dynamic>),
  sSHConfig:
      json['SSHConfig'] == null
          ? null
          : SSHConfig.fromJson(json['SSHConfig'] as Map<String, dynamic>),
  userModeNetworking: json['UserModeNetworking'] as bool?,
  rootful: json['Rootful'] as bool?,
  rosetta: json['Rosetta'] as bool?,
);

Map<String, dynamic> _$MachineInspectToJson(MachineInspect instance) =>
    <String, dynamic>{
      'ConfigDir': instance.configDir,
      'ConnectionInfo': instance.connectionInfo,
      'Created': instance.created?.toIso8601String(),
      'LastUp': instance.lastUp?.toIso8601String(),
      'Name': instance.name,
      'State': instance.state,
      'Resources': instance.resources,
      'SSHConfig': instance.sSHConfig,
      'UserModeNetworking': instance.userModeNetworking,
      'Rootful': instance.rootful,
      'Rosetta': instance.rosetta,
    };
