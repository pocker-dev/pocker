import 'dart:convert';

import 'package:pocker/services/client/http_socket.dart';
import 'package:pocker/services/client/stream_socket.dart';
import 'package:pocker/services/model/pruned_response.dart';

import 'model/pod_inspect.dart';
import 'model/pod_operate.dart';
import 'model/pod_removed.dart';
import 'model/pod_summary.dart';

class PodApi {
  PodApi(String socket)
      : _http = HttpSocket(socket: socket),
        _stream = StreamSocket(socket: socket);

  final HttpSocket _http;
  final StreamSocket _stream;

  /// List pods
  ///
  /// Returns a list of pods.
  Future<List<PodSummary>> listPods() async {
    List<dynamic> list = await _http.get(
      path: '/pods/json',
      queryParams: {},
    );
    return list.map((json) => PodSummary.fromJson(json)).toList();
  }

  /// Inspect pod
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Name of the pod.
  Future<PodInspect> inspectPod({required String name}) async {
    Map<String, dynamic> inspect = await _http.get(
      path: '/pods/$name/json',
    );
    return PodInspect.fromJson(inspect);
  }

  /// Generate a Kubernetes YAML file.
  ///
  /// Generate Kubernetes YAML based on a pod or container.
  Future<String> generateYAML({required String name}) async {
    final respBytes = await _http.getRaw(
      path: '/generate/kube',
      queryParams: {
        'names': name,
      },
    );
    return utf8.decode(respBytes).toString().trim();
  }

  /// Prune unused pods
  Future<PrunedResponse> prunePods() async {
    Map<String, dynamic> operate = await _http.post(
      path: '/pods/prune',
    );
    return PrunedResponse.fromJson(operate);
  }

  /// Remove pod
  Future<PodRemoved> removePod({required String name}) async {
    Map<String, dynamic> operate =
        await _http.delete(path: '/pods/$name', queryParams: {
      'force': true.toString(),
    });
    return PodRemoved.fromJson(operate);
  }

  /// Start a pod
  Future<PodOperate> startPod({required String name}) async {
    Map<String, dynamic> operate = await _http.post(
      path: '/pods/$name/start',
    );
    return PodOperate.fromJson(operate);
  }

  /// Stop a pod
  Future<PodOperate> stopPod({required String name}) async {
    Map<String, dynamic> operate =
        await _http.post(path: '/pods/$name/stop', queryParams: {
      // 't': '60', // timeout
    });
    return PodOperate.fromJson(operate);
  }

  /// Kill a pod
  Future<PodOperate> killPod({required String name}) async {
    Map<String, dynamic> operate =
        await _http.post(path: '/pods/$name/kill', queryParams: {
      'signal': 'SIGKILL',
    });
    return PodOperate.fromJson(operate);
  }

  /// Restart a pod
  Future<PodOperate> restartPod({required String name}) async {
    Map<String, dynamic> operate = await _http.post(
      path: '/pods/$name/restart',
    );
    return PodOperate.fromJson(operate);
  }
}
