import 'dart:convert';
import 'dart:io';

import 'package:pocker/services/client/http_socket.dart';
import 'package:pocker/services/client/stream_socket.dart';
import 'package:pocker/services/model/pruned_response.dart';

import 'model/image_build_progress.dart';
import 'model/image_history.dart';
import 'model/image_inspect.dart';
import 'model/image_pull_progress.dart';
import 'model/image_removed.dart';
import 'model/image_summary.dart';

class ImageApi {
  ImageApi(String socket)
      : _http = HttpSocket(socket: socket),
        _stream = StreamSocket(socket: socket);

  final HttpSocket _http;
  final StreamSocket _stream;

  /// List Images
  ///
  /// Returns a list of images on the server. Note that it uses a different,
  /// smaller representation of an image than inspecting a single image.
  Future<List<ImageSummary>> listImages() async {
    List<dynamic> list = await _http.get(
      path: '/images/json',
      queryParams: {},
    );
    return list.map((json) => ImageSummary.fromJson(json)).toList();
  }

  /// Create image
  Future<void> buildImage({
    required String dockerfile,
    required List<int> contextTar,
    required String t,
    Map<String, String>? buildArgs,
    Function(List<ImageBuildProgress>)? onData,
    Function()? onFinished,
  }) async {
    await _stream.post(
      compat: true,
      path: '/build',
      queryParams: {
        't': t,
        'buildargs': buildArgs != null ? json.encode(buildArgs) : '',
        'dockerfile': dockerfile,
      },
      headers: {
        HttpHeaders.contentTypeHeader: 'application/tar',
        HttpHeaders.contentLengthHeader: '${contextTar.length}',
      },
      body: contextTar,
      onData: onData == null
          ? null
          : (String val) {
              final list = <ImageBuildProgress>[];
              for (var line in val.split('\n')) {
                line = line.trim();
                if (line.isEmpty) {
                  continue;
                }
                list.add(ImageBuildProgress.fromJson(json.decode(line)));
              }
              if (list.isNotEmpty) {
                onData(list);
              }
            },
      onFinished: onFinished,
    );
  }

  /// Pull an image
  ///
  /// Pull an image from a registry.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Name of the image to pull. For example, registry.example.com/myimage.
  ///
  /// * [String] tag:
  ///   Tag of the image to pull.
  ///
  /// * [Function] onData:
  ///   Pulling status callback.
  ///
  /// * [Function] onFinished:
  ///   Pulling finished status callback.
  Future<void> pullImage({
    required String name,
    required String tag,
    Function(List<ImagePulledProgress>)? onData,
    Function()? onFinished,
  }) async {
    await _stream.post(
      path: '/images/pull',
      queryParams: {
        'reference': '$name:$tag',
      },
      onData: onData == null
          ? null
          : (String val) {
              final list = <ImagePulledProgress>[];
              for (var line in val.split('\n')) {
                line = line.trim();
                if (line.isEmpty) {
                  continue;
                }
                list.add(ImagePulledProgress.fromJson(json.decode(line)));
              }
              if (list.isNotEmpty) {
                onData(list);
              }
            },
      onFinished: onFinished,
    );
  }

  /// Inspect an image
  ///
  /// Return low-level information about an image.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Image name or id
  Future<ImageInspect> inspectImage({required String name}) async {
    Map<String, dynamic> inspect =
        await _http.get(path: '/images/$name/json', compat: true);
    return ImageInspect.fromJson(inspect);
  }

  /// Get the history of an image
  ///
  /// Return parent layers of an image.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Image name or ID
  Future<List<ImageHistory>> imageHistory({
    required String name,
  }) async {
    List<dynamic> history = await _http.get(path: '/images/$name/history');
    return history.map((json) => ImageHistory.fromJson(json)).toList();
  }

  /// Tag an image
  ///
  /// Tag an image so that it becomes part of a repository.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Image name or ID to tag.
  ///
  /// * [String] repo:
  ///   The repository to tag in. For example, `someuser/someimage`.
  ///
  /// * [String] tag:
  ///   The name of the new tag.
  Future<void> tagImage({
    required String name,
    required String repo,
    required String tag,
  }) async {
    await _http.post(path: '/images/$name/tag', queryParams: {
      'repo': repo,
      'tag': tag,
    });
  }

  /// Remove an image
  ///
  /// Remove an image, along with any untagged parent images that were referenced by that image.
  /// Images can't be removed if they have descendant images, are being used by a running container or are being used by a build.
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Image name or ID
  Future<ImageRemoved> removeImage({required String name}) async {
    Map<String, dynamic> removed = await _http.delete(
      path: '/images/$name',
      queryParams: {
        'force': true.toString(),
      },
    );
    return ImageRemoved.fromJson(removed);
  }

  /// Prune unused images
  ///
  /// Remove images that are not being used by a container.
  Future<List<PrunedResponse>> pruneImages() async {
    List<dynamic> pruned = await _http.post(
      path: '/images/prune',
      queryParams: {
        'all': true.toString(),
        'buildcache': false.toString(),
        'external': false.toString(),
      },
    );
    return pruned.map((json) => PrunedResponse.fromJson(json)).toList();
  }

  /// Export several images
  Future<void> exportImages({
    required List<String> names,
    required String path,
  }) async {
    final respBytes = await _http.getRaw(
      path: '/images/get',
      queryParams: {
        'names': names.join(","),
      },
      compat: true,
    );
    final file = File(path);
    await file.writeAsBytes(respBytes);
  }

  /// Import image
  Future<void> importImage({required String path}) async {
    final file = File(path);
    if (await file.exists()) {
      final bodyBytes = await file.readAsBytes();
      await _http.postRaw(
        path: '/images/load',
        queryParams: {},
        headers: {
          'Content-Type': 'application/x-tar',
        },
        body: bodyBytes,
        compat: true,
      );
    }
  }
}
