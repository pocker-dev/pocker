// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pod_container_inspect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodContainerInspect _$PodContainerInspectFromJson(Map<String, dynamic> json) =>
    PodContainerInspect(
      id: json['Id'] as String,
      name: json['Name'] as String,
      state: json['State'] as String,
    );

Map<String, dynamic> _$PodContainerInspectToJson(
  PodContainerInspect instance,
) => <String, dynamic>{
  'Id': instance.id,
  'Name': instance.name,
  'State': instance.state,
};
