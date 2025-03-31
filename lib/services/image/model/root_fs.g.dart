// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root_fs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RootFS _$RootFSFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['Type']);
  return RootFS(
    fsType: json['Type'] as String,
    layers:
        (json['Layers'] as List<dynamic>?)?.map((e) => e as String).toList() ??
        const [],
  );
}

Map<String, dynamic> _$RootFSToJson(RootFS instance) => <String, dynamic>{
  'Type': instance.fsType,
  'Layers': instance.layers,
};
