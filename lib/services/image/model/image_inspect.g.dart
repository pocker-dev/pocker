// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_inspect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInspect _$ImageInspectFromJson(Map<String, dynamic> json) => ImageInspect(
  id: json['Id'] as String,
  repoTags:
      (json['RepoTags'] as List<dynamic>).map((e) => e as String).toList(),
  repoDigests:
      (json['RepoDigests'] as List<dynamic>).map((e) => e as String).toList(),
  parent: json['Parent'] as String,
  comment: json['Comment'] as String,
  created: json['Created'] as String,
  container: json['Container'] as String,
  containerConfig: ContainerConfig.fromJson(
    json['ContainerConfig'] as Map<String, dynamic>,
  ),
  dockerVersion: json['DockerVersion'] as String,
  author: json['Author'] as String,
  config: ImageConfig.fromJson(json['Config'] as Map<String, dynamic>),
  architecture: json['Architecture'] as String,
  variant: json['Variant'] as String?,
  os: json['Os'] as String,
  osVersion: json['OsVersion'] as String?,
  size: (json['Size'] as num).toInt(),
  virtualSize: (json['VirtualSize'] as num).toInt(),
  graphDriver: GraphDriverData.fromJson(
    json['GraphDriver'] as Map<String, dynamic>,
  ),
  rootFS: RootFS.fromJson(json['RootFS'] as Map<String, dynamic>),
  metadata: ImageMetadata.fromJson(json['Metadata'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ImageInspectToJson(ImageInspect instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'RepoTags': instance.repoTags,
      'RepoDigests': instance.repoDigests,
      'Parent': instance.parent,
      'Comment': instance.comment,
      'Created': instance.created,
      'Container': instance.container,
      'ContainerConfig': instance.containerConfig,
      'DockerVersion': instance.dockerVersion,
      'Author': instance.author,
      'Config': instance.config,
      'Architecture': instance.architecture,
      'Variant': instance.variant,
      'Os': instance.os,
      'OsVersion': instance.osVersion,
      'Size': instance.size,
      'VirtualSize': instance.virtualSize,
      'GraphDriver': instance.graphDriver,
      'RootFS': instance.rootFS,
      'Metadata': instance.metadata,
    };
