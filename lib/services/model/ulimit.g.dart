// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ulimit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ulimit _$UlimitFromJson(Map<String, dynamic> json) => Ulimit(
  name: json['Name'] as String,
  hard: (json['Hard'] as num).toInt(),
  soft: (json['Soft'] as num).toInt(),
);

Map<String, dynamic> _$UlimitToJson(Ulimit instance) => <String, dynamic>{
  'Name': instance.name,
  'Hard': instance.hard,
  'Soft': instance.soft,
};
