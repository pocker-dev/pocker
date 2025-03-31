// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_removed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageRemoved _$ImageRemovedFromJson(Map<String, dynamic> json) => ImageRemoved(
  deleted:
      (json['Deleted'] as List<dynamic>?)?.map((e) => e as String).toList(),
  errors: (json['Errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
  exitCode: (json['ExitCode'] as num?)?.toInt(),
  untagged:
      (json['Untagged'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ImageRemovedToJson(ImageRemoved instance) =>
    <String, dynamic>{
      'Deleted': instance.deleted,
      'Errors': instance.errors,
      'ExitCode': instance.exitCode,
      'Untagged': instance.untagged,
    };
