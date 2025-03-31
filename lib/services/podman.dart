import 'container/container_api.dart';
import 'image/image_api.dart';
import 'machine.dart';
import 'pod/pod_api.dart';
import 'system/system_api.dart';
import 'volume/volume_api.dart';

class Podman {
  static Podman? _instance;

  Podman._internal(String socket) : _socket = socket;

  factory Podman() {
    if (_instance == null) {
      final inspect = Machine.inspect();
      if (inspect != null) {
        final path = inspect.connectionInfo?.podmanSocket?.path;
        if (path != null) {
          _instance = Podman._internal(path);
        }
      }
    }
    return _instance!;
  }

  static Future<Podman?> getInstance() async {
    final podman = Podman();
    if (await podman.system.ping()) {
      return podman;
    }
    return null;
  }

  final String _socket;

  /// Return system api
  SystemApi get system {
    return SystemApi(_socket);
  }

  /// Return image api
  ImageApi get image {
    return ImageApi(_socket);
  }

  /// Return volume api
  VolumeApi get volume {
    return VolumeApi(_socket);
  }

  /// Return pod api
  PodApi get pod {
    return PodApi(_socket);
  }

  /// Return container api
  ContainerApi get container {
    return ContainerApi(_socket);
  }
}
