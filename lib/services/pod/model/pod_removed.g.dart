// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pod_removed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodRemoved _$PodRemovedFromJson(Map<String, dynamic> json) =>
    PodRemoved(id: json['Id'] as String?, err: json['Err'] as String?)
      ..removedCtrs = json['RemovedCtrs'] as Map<String, dynamic>?;

Map<String, dynamic> _$PodRemovedToJson(PodRemoved instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Err': instance.err,
      'RemovedCtrs': instance.removedCtrs,
    };
