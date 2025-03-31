import 'dart:convert';

import 'package:pocker/core/utils/stream_decoder.dart';
import 'package:pocker/services/client/http_socket.dart';
import 'package:pocker/services/client/stream_socket.dart';
import 'package:pocker/services/container/model/container_stats_list.dart';

import 'model/container_inspect.dart';
import 'model/container_stats.dart';
import 'model/container_summary.dart';

class ContainerApi {
  ContainerApi(String socket)
      : _http = HttpSocket(socket: socket),
        _stream = StreamSocket(socket: socket);

  final HttpSocket _http;
  final StreamSocket _stream;

  /// List Containers
  ///
  /// Returns a list of containers
  Future<List<ContainerSummary>> listContainers() async {
    List<dynamic> list = await _http.get(
      path: '/containers/json',
      queryParams: {
        'all': true.toString(),
      },
    );
    return list.map((json) => ContainerSummary.fromJson(json)).toList();
  }

  /// Inspect container
  Future<ContainerInspect> inspectContainer({required String name}) async {
    Map<String, dynamic> inspect = await _http.get(
      path: '/containers/$name/json',
      compat: true,
    );
    return ContainerInspect.fromJson(inspect);
  }

  /// Get stats for a container
  Future<void> getContainerStats({
    required String name,
    Function(List<ContainerStats>)? onData,
    Function()? onFinished,
  }) async {
    await _stream.get(
      path: '/containers/stats',
      queryParams: {
        'containers': name,
        'stream': true.toString(),
      },
      onData: onData == null
          ? null
          : (List<int> stream) {
              final list = <ContainerStats>[];
              for (var line in StreamDecoder.toLines(stream)) {
                line = line.trim();
                if (line.isEmpty) {
                  continue;
                }
                final wrapper = ContainerStatsList.fromJson(json.decode(line));
                list.addAll(wrapper.stats);
              }
              if (list.isNotEmpty) {
                onData(list);
              }
            },
      onFinished: onFinished,
    );
  }

  Future<void> tailContainerLog({
    required String name,
    Function(List<String>)? onData,
    Function()? onFinished,
  }) async {
    List<int> buffer = [];
    await _stream.get(
      path: '/containers/$name/logs',
      queryParams: {
        'follow': true.toString(),
        'stderr': true.toString(),
        'stdout': true.toString(),
      },
      onData: onData == null
          ? null
          : (List<int> stream) async {
              if (buffer.isNotEmpty) {
                buffer = stream;
              } else {
                buffer.addAll(stream);
              }
              buffer = await StreamDecoder.toLogs(buffer, onData);
            },
      onFinished: onFinished,
    );
  }

  /// Start a container
  Future<void> startContainer({required String name}) async {
    await _http.post(
      path: '/containers/$name/start',
    );
  }

  /// Stop a container
  Future<void> stopContainer({required String name}) async {
    await _http.post(
      path: '/containers/$name/stop',
      queryParams: {
        'Ignore': true.toString(),
      },
    );
  }

  /// Restart a container
  Future<void> restartContainer({required String name}) async {
    await _http.post(
      path: '/containers/$name/restart',
    );
  }

  /// Delete container
  Future<void> deleteContainer({required String name}) async {
    await _http.delete(
      path: '/containers/$name',
      queryParams: {
        'force': true.toString(),
        'v': true.toString(),
      },
    );
  }
}
