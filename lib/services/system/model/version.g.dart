// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) => Version(
  version: json['Version'] as String,
  apiVersion: json['ApiVersion'] as String?,
  os: json['Os'] as String,
  osArch: json['OsArch'] as String,
);

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
  'Version': instance.version,
  'ApiVersion': instance.apiVersion,
  'Os': instance.os,
  'OsArch': instance.osArch,
};
