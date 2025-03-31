import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/circular_progress.dart';
import 'package:pocker/core/widgets/engine_not_found.dart';
import 'package:pocker/services/machine.dart';
import 'package:pocker/services/model/machine_inspect.dart';
import 'package:pocker/services/podman.dart';
import 'package:pocker/services/system/model/info.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Timer? _timer;

  late Info _info;
  late MachineInspect _inspect;
  bool _running = false;

  void _requestMachineInspect() async {
    final inspect = Machine.inspect();
    if (inspect != null) {
      _inspect = inspect;
    }
  }

  void _requestMachineInfo() async {
    final podman = await Podman.getInstance();
    if (podman != null) {
      final info = await podman.system.getInfo();
      setState(() {
        _info = info;
        _running = true;
      });
    } else {
      setState(() {
        _running = false;
      });
    }
  }

  Widget _buildProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularProgress(
          size: CircularProgressSize.large,
          value: (_info.host.cpuUtilization.userPercent +
                  _info.host.cpuUtilization.systemPercent) /
              100,
          title: 'CPU(s)',
          subtitle: _info.host.cpus.toString(),
          tooltip: 'dashboard_cpu_usage'.tr(args: [
            (_info.host.cpuUtilization.userPercent +
                    _info.host.cpuUtilization.systemPercent)
                .toStringAsFixed(0)
          ]),
        ),
        CircularProgress(
          size: CircularProgressSize.large,
          value: _info.store.graphRootUsed / _info.store.graphRootAllocated,
          title: 'Disk size',
          subtitle:
              StringBeautify.formatStorageSize(_info.store.graphRootAllocated),
          tooltip: 'dashboard_disk_usage'.tr(args: [
            (_info.store.graphRootUsed * 100 / _info.store.graphRootAllocated)
                .toStringAsFixed(0),
          ]),
        ),
        CircularProgress(
          size: CircularProgressSize.large,
          value:
              (_info.host.memTotal - _info.host.memFree) / _info.host.memTotal,
          title: 'Memory',
          subtitle: StringBeautify.formatStorageSize(_info.host.memTotal),
          tooltip: 'dashboard_memory_usage'.tr(args: [
            ((_info.host.memTotal - _info.host.memFree) *
                    100 /
                    _info.host.memTotal)
                .toStringAsFixed(0),
          ]),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100.0,
              child: SelectableText(
                'engine_status_label'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SelectableText(
              _inspect.state?.toUpperCase() ?? '',
              style: TextStyle(
                color: _running ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 100.0,
              child: SelectableText(
                'engine_version_label'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SelectableText('v${_info.version.version}'),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 100.0,
              child: SelectableText(
                'engine_endpoint_label'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SelectableText(
                'unix://${_inspect.connectionInfo?.podmanSocket?.path}',
                maxLines: 1,
              ),
            ),
            SizedBox(width: 10.0),
            Tooltip(
              message: 'copy_to_clipboard'.tr(),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Icon(Symbols.content_copy, size: 16.0),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(
                      text:
                          'unix://${_inspect.connectionInfo?.podmanSocket?.path}',
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions() {
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Tooltip(
          message: 'engine_start_tooltip'.tr(),
          child: TextButton.icon(
            onPressed: _running ? null : () => Machine.start(),
            label: Text('engine_start_label'.tr()),
            icon: Icon(Symbols.play_arrow, fill: 1),
          ),
        ),
        Tooltip(
          message: 'engine_restart_tooltip'.tr(),
          child: TextButton.icon(
            onPressed: _running ? () => Machine.restart() : null,
            label: Text('engine_restart_label'.tr()),
            icon: Icon(Symbols.restart_alt),
          ),
        ),
        Tooltip(
          message: 'engine_stop_tooltip'.tr(),
          child: TextButton.icon(
            onPressed: _running ? () => Machine.stop() : null,
            label: Text('engine_stop_label'.tr()),
            icon: Icon(Symbols.stop, fill: 1),
          ),
        ),
        Tooltip(
          message: 'engine_edit_tooltip'.tr(),
          child: TextButton.icon(
            onPressed: () async {},
            label: Text('engine_edit_label'.tr()),
            icon: Icon(Symbols.edit_square),
          ),
        ),
        Tooltip(
          message: 'engine_delete_tooltip'.tr(),
          child: TextButton.icon(
            onPressed: _running ? null : () => Machine.delete(),
            label: Text('engine_delete_label'.tr()),
            icon: Icon(Symbols.delete),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    //
    _requestMachineInspect();
    _requestMachineInfo();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _requestMachineInfo();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        spacing: 20.0,
        children: [
          Row(
            spacing: 5.0,
            children: [
              SelectableText(
                'Podman Machine',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20.0,
                children: [
                  if (_running) _buildProgress(),
                  if (!_running)
                    Image.asset(
                      'assets/images/podman.png',
                      width: 128,
                      height: 128,
                      cacheWidth: 128,
                      cacheHeight: 128,
                    ),
                  _buildActions(),
                  if (_running) _buildSummary(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
