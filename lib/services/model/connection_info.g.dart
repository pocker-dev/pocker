// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionInfo _$ConnectionInfoFromJson(Map<String, dynamic> json) =>
    ConnectionInfo(
      podmanSocket:
          json['PodmanSocket'] == null
              ? null
              : ConfigPath.fromJson(
                json['PodmanSocket'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ConnectionInfoToJson(ConnectionInfo instance) =>
    <String, dynamic>{'PodmanSocket': instance.podmanSocket};
