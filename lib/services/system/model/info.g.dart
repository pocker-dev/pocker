// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
  host: Host.fromJson(json['host'] as Map<String, dynamic>),
  store: Store.fromJson(json['store'] as Map<String, dynamic>),
  version: Version.fromJson(json['version'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
  'host': instance.host,
  'store': instance.store,
  'version': instance.version,
};
