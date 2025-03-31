import 'dart:convert';

import 'package:pocker/core/utils/stream_decoder.dart';
import 'package:pocker/services/client/http_socket.dart';
import 'package:pocker/services/client/stream_socket.dart';
import 'package:pocker/services/system/model/disk_usage.dart';

import 'model/event.dart';
import 'model/info.dart';

class SystemApi {
  SystemApi(String socket)
      : _http = HttpSocket(socket: socket),
        _stream = StreamSocket(socket: socket);

  final HttpSocket _http;
  final StreamSocket _stream;

  /// Ping service
  Future<bool> ping() async {
    try {
      final pong = await _http.getRaw(
        path: '/_ping',
        queryParams: {},
      );
      return utf8.decode(pong).toString().trim() == 'OK';
    } catch (e) {
      return false;
    }
  }

  /// Get events
  Future<void> watchEvents({
    Function(Event)? onEvent,
    Function()? onStopped,
  }) async {
    await _stream.get(
      path: '/events',
      queryParams: {},
      onData: onEvent == null
          ? null
          : (List<int> stream) {
              for (var line in StreamDecoder.toLines(stream)) {
                line = line.trim();
                if (line.isEmpty) {
                  continue;
                }
                onEvent(Event.fromJson(json.decode(line)));
              }
            },
      onFinished: onStopped,
    );
  }

  /// Get info
  ///
  /// Returns information on the system and libpod configuration
  Future<Info> getInfo() async {
    Map<String, dynamic> info = await _http.get(
      path: '/info',
    );
    return Info.fromJson(info);
  }

  /// Show disk usage
  ///
  /// Return information about disk usage for containers, images, and volumes
  Future<DiskUsage> showDiskUsage() async {
    Map<String, dynamic> diskUsage = await _http.get(
      path: '/system/df',
    );
    return DiskUsage.fromJson(diskUsage);
  }
}
