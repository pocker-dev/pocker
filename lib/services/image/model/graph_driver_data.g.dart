// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_driver_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphDriverData _$GraphDriverDataFromJson(Map<String, dynamic> json) =>
    GraphDriverData(
      name: json['Name'] as String,
      data: Map<String, String>.from(json['Data'] as Map),
    );

Map<String, dynamic> _$GraphDriverDataToJson(GraphDriverData instance) =>
    <String, dynamic>{'Name': instance.name, 'Data': instance.data};
