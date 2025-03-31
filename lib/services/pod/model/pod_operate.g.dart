// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pod_operate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodOperate _$PodOperateFromJson(Map<String, dynamic> json) => PodOperate(
  id: json['Id'] as String?,
  rawInput: json['RawInput'] as String?,
  errs: (json['Errs'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$PodOperateToJson(PodOperate instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'RawInput': instance.rawInput,
      'Errs': instance.errs,
    };
