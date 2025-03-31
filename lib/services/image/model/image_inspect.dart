import 'package:json_annotation/json_annotation.dart';

import 'container_config.dart';
import 'graph_driver_data.dart';
import 'image_config.dart';
import 'image_metadata.dart';
import 'root_fs.dart';

part 'image_inspect.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class ImageInspect {
  ImageInspect({
    required this.id,
    required this.repoTags,
    required this.repoDigests,
    required this.parent,
    required this.comment,
    required this.created,
    required this.container,
    required this.containerConfig,
    required this.dockerVersion,
    required this.author,
    required this.config,
    required this.architecture,
    this.variant,
    required this.os,
    this.osVersion,
    required this.size,
    required this.virtualSize,
    required this.graphDriver,
    required this.rootFS,
    required this.metadata,
  });

  /// ID is the content-addressable ID of an image.
  ///
  /// This identifier is a content-addressable digest calculated from
  /// the image's configuration (which includes the digests of layers used by the image).
  ///
  /// Note that this digest differs from the RepoDigests below,
  /// which holds digests of image manifests that reference the image.
  String id;

  /// List of image names/tags in the local image cache that reference this image.
  ///
  /// Multiple image tags can refer to the same image, and this list may be empty if
  /// no tags reference the image, in which case the image is "untagged",
  /// in which case it can still be referenced by its ID.
  List<String> repoTags;

  /// List of content-addressable digests of locally available image manifests
  /// that the image is referenced from. Multiple manifests can refer to the same image.
  ///
  /// These digests are usually only available if the image was either pulled from a registry,
  /// or if the image was pushed to a registry, which is when the manifest is generated
  /// and its digest calculated.
  List<String> repoDigests;

  /// ID of the parent image.
  ///
  /// Depending on how the image was created, this field may be empty and is only set
  /// for images that were built/created locally.
  /// This field is empty if the image was pulled from an image registry.
  String parent;

  /// Optional message that was set when committing or importing the image.
  String comment;

  /// Date and time at which the image was created,
  /// formatted in RFC 3339 format with nano-seconds.
  String created;

  /// The ID of the container that was used to create the image.
  ///
  /// Depending on how the image was created, this field may be empty.
  String container;

  /// Configuration for a container that is portable between hosts.
  ///
  /// When used as ContainerConfig field in an image, ContainerConfig is
  /// an optional field containing the configuration of the container
  /// that was last committed when creating the image.
  ///
  /// Previous versions of Docker builder used this field to store build cache,
  /// and it is not in active use anymore.
  ContainerConfig containerConfig;

  /// The version of Docker that was used to build the image.
  ///
  /// Depending on how the image was created, this field may be empty.
  String dockerVersion;

  /// Name of the author that was specified when committing the image,
  /// or as specified through MAINTAINER (deprecated) in the Dockerfile.
  String author;

  /// Configuration of the image. These fields are used as defaults
  /// when starting a container from the image.
  ImageConfig config;

  /// Hardware CPU architecture that the image runs on.
  String architecture;

  /// CPU architecture variant (presently ARM-only).
  String? variant;

  /// Operating System the image is built to run on.
  String os;

  /// Operating System version the image is built to run on (especially for Windows).
  String? osVersion;

  /// Total size of the image including all layers it is composed of.
  int size;

  /// Total size of the image including all layers it is composed of.
  ///
  /// In versions of Docker before v1.10, this field was calculated from the image
  /// itself and all of its parent images. Docker v1.10 and up store images self-contained,
  /// and no longer use a parent-chain, making this field an equivalent of the Size field.
  ///
  /// This field is kept for backward compatibility,
  /// but may be removed in a future version of the API.
  int virtualSize;

  /// Information about the storage driver used to store the container's and image's filesystem.
  GraphDriverData graphDriver;

  /// Information about the image's RootFS, including the layer IDs.
  RootFS rootFS;

  /// Additional metadata of the image in the local cache.
  /// This information is local to the daemon, and not part of the image itself.
  ImageMetadata metadata;

  String get shortId {
    return id.length > 19 ? id.substring(7, 19) : id;
  }

  factory ImageInspect.fromJson(Map<String, dynamic> json) =>
      _$ImageInspectFromJson(json);

  Map<String, dynamic> toJson() => _$ImageInspectToJson(this);
}
