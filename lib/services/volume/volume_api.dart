import 'package:pocker/services/client/http_socket.dart';
import 'package:pocker/services/client/stream_socket.dart';
import 'package:pocker/services/model/pruned_response.dart';
import 'package:pocker/services/volume/model/volume_create_req.dart';
import 'package:pocker/services/volume/model/volume_inspect.dart';

import 'model/volume_create_resp.dart';
import 'model/volume_summary.dart';

class VolumeApi {
  VolumeApi(String socket)
      : _http = HttpSocket(socket: socket),
        _stream = StreamSocket(socket: socket);

  final HttpSocket _http;
  final StreamSocket _stream;

  /// List Volumes
  ///
  /// Returns a list of volumes.
  Future<List<VolumeSummary>> listVolumes() async {
    List<dynamic> resp = await _http.get(
      path: '/volumes/json',
      queryParams: {},
    );
    final list = resp.map((json) => VolumeSummary.fromJson(json)).toList();
    list.sort((a, b) {
      return a.name.compareTo(b.name);
    });
    return list;
  }

  /// Create a volume
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Name of the volume.
  Future<VolumeCreateResp> createVolume({required String name}) async {
    final req = VolumeCreateReq(
      driver: 'local',
      ignoreIfExists: true,
      label: {},
      labels: {},
      name: name,
      options: {},
    );
    Map<String, dynamic> create = await _http.post(
      path: '/volumes/create',
      body: req,
    );
    return VolumeCreateResp.fromJson(create);
  }

  /// Inspect a volume
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Name of the volume.
  Future<VolumeInspect> inspectVolume({required String name}) async {
    Map<String, dynamic> inspect = await _http.get(
      path: '/volumes/$name',
      compat: true,
    );
    return VolumeInspect.fromJson(inspect);
  }

  /// Remove volume
  ///
  /// Parameters:
  ///
  /// * [String] name:
  ///   Name of the volume.
  ///
  /// * [bool] force:
  ///   Force removal.
  Future<void> removeVolume({
    required String name,
    bool force = false,
  }) async {
    _http.delete(
      path: '/volumes/$name',
      queryParams: {
        'force': false.toString(),
      },
    );
  }

  /// Prune volumes
  Future<List<PrunedResponse>> pruneVolumes() async {
    List<dynamic> pruned = await _http.post(
      path: '/volumes/prune',
    );
    return pruned.map((json) => PrunedResponse.fromJson(json)).toList();
  }
}
