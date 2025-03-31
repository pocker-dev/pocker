import 'package:pocker/services/podman.dart';

Future<void> startContainer(String id) async {
  final podman = await Podman.getInstance();
  if (podman == null) {
    return;
  }
  //
  await podman.container.startContainer(name: id);
}

Future<void> stopContainer(String id) async {
  final podman = await Podman.getInstance();
  if (podman == null) {
    return;
  }
  //
  await podman.container.stopContainer(name: id);
}

Future<void> restartContainer(String id) async {
  final podman = await Podman.getInstance();
  if (podman == null) {
    return;
  }
  //
  await podman.container.restartContainer(name: id);
}
