import 'package:pocker/services/podman.dart';

Future<void> startPod(String id) async {
  final podman = await Podman.getInstance();
  if (podman == null) {
    return;
  }
  //
  await podman.pod.startPod(name: id);
}

Future<void> stopPod(String id) async {
  final podman = await Podman.getInstance();
  if (podman == null) {
    return;
  }
  //
  await podman.pod.stopPod(name: id);
}

Future<void> restartPod(String id) async {
  final podman = await Podman.getInstance();
  if (podman == null) {
    return;
  }
  //
  await podman.pod.restartPod(name: id);
}
