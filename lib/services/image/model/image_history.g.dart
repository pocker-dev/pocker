// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageHistory _$ImageHistoryFromJson(Map<String, dynamic> json) => ImageHistory(
  id: json['Id'] as String,
  created: (json['Created'] as num).toInt(),
  createdBy: json['CreatedBy'] as String,
  tags: (json['Tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  size: (json['Size'] as num).toInt(),
  comment: json['Comment'] as String,
);

Map<String, dynamic> _$ImageHistoryToJson(ImageHistory instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Created': instance.created,
      'CreatedBy': instance.createdBy,
      'Tags': instance.tags,
      'Size': instance.size,
      'Comment': instance.comment,
    };
