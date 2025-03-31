// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pruned_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrunedResponse _$PrunedResponseFromJson(Map<String, dynamic> json) =>
    PrunedResponse(
      err: json['Err'] as String?,
      id: json['Id'] as String?,
      size: (json['Size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PrunedResponseToJson(PrunedResponse instance) =>
    <String, dynamic>{
      'Err': instance.err,
      'Id': instance.id,
      'Size': instance.size,
    };
