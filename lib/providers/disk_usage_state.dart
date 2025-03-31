import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocker/services/podman.dart';
import 'package:pocker/services/system/model/container_usage.dart';
import 'package:pocker/services/system/model/image_usage.dart';
import 'package:pocker/services/system/model/volume_usage.dart';

class DiskUsageState extends ChangeNotifier {
  Timer? _timer;

  List<ContainerUsage>? _containers;
  List<ImageUsage>? _images;
  List<VolumeUsage>? _volumes;
  int? _imagesSize;

  List<ContainerUsage>? get containers => _containers;

  List<ImageUsage>? get images => _images;

  List<VolumeUsage>? get volumes => _volumes;

  void startTimer({Duration interval = const Duration(seconds: 2)}) {
    _refresh();
    _timer?.cancel();
    _timer = Timer.periodic(interval, (timer) {
      _refresh();
    });
  }

  Future<void> _refresh() async {
    final podman = await Podman.getInstance();
    if (podman != null) {
      final usage = await podman.system.showDiskUsage();
      _containers = usage.containers;
      _images = usage.images;
      _volumes = usage.volumes;
      _imagesSize = usage.imagesSize;
    } else {
      _containers = null;
      _images = null;
      _volumes = null;
      _imagesSize = null;
    }
    //
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
