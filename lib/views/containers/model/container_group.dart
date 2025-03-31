import 'package:pocker/services/container/model/container_summary.dart';
import 'package:pocker/services/pod/model/pod_summary.dart';

class ContainerGroup {
  ContainerGroup.standalone(ContainerSummary container)
      : id = container.id,
        name = container.names[0],
        status = container.state,
        created = container.created,
        containers = [container];

  ContainerGroup.pod(PodSummary pod, ContainerSummary container)
      : id = pod.id,
        name = pod.name,
        status = pod.status,
        created = pod.created,
        containers = [container];

  String id;
  String name;
  String status;
  DateTime created;

  List<ContainerSummary> containers;

  void add(ContainerSummary container) {
    containers.add(container);
    containers.sort((a, b) {
      if (a.names.isNotEmpty && b.names.isNotEmpty) {
        return a.names[0].compareTo(b.names[0]);
      }
      return a.created.compareTo(b.created);
    });
  }

  bool isStandalone() {
    return containers.length == 1 && id == containers[0].id;
  }

  bool isCompose() {
    for (final container in containers) {
      if (container.labels == null) {
        continue;
      }
      for (final key in container.labels!.keys) {
        if (key.toLowerCase().startsWith('com.docker.compose')) {
          return true;
        }
      }
    }
    return false;
  }

  String _composeName() {
    for (final container in containers) {
      for (final entry in container.labels!.entries) {
        if (entry.key.toLowerCase() == 'io.podman.compose.project') {
          return entry.value;
        }
      }
    }
    return '';
  }

  String displayTitle() {
    if (isStandalone()) {
      return name;
    }
    if (isCompose()) {
      return '${_composeName()} (compose)';
    }
    return '$name (pod)';
  }
}
