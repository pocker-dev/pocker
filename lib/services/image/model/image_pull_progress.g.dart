// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_pull_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagePulledProgress _$ImagePulledProgressFromJson(Map<String, dynamic> json) =>
    ImagePulledProgress(
      id: json['id'] as String?,
      stream: json['stream'] as String?,
      error: json['error'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ImagePulledProgressToJson(
  ImagePulledProgress instance,
) => <String, dynamic>{
  'id': instance.id,
  'stream': instance.stream,
  'error': instance.error,
  'images': instance.images,
};
