// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineResource _$MachineResourceFromJson(Map<String, dynamic> json) =>
    MachineResource(
      cPUs: (json['CPUs'] as num).toInt(),
      diskSize: (json['DiskSize'] as num).toInt(),
      memory: (json['Memory'] as num).toInt(),
      uSBs: (json['USBs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MachineResourceToJson(MachineResource instance) =>
    <String, dynamic>{
      'CPUs': instance.cPUs,
      'DiskSize': instance.diskSize,
      'Memory': instance.memory,
      'USBs': instance.uSBs,
    };
