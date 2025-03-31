import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/engine_not_found.dart';
import 'package:pocker/providers/disk_usage_state.dart';
import 'package:pocker/services/system/model/container_usage.dart';
import 'package:provider/provider.dart';

import 'utils/prune_pods.dart';
import 'widgets/pod_list.dart';

class PodsPage extends StatefulWidget {
  const PodsPage({super.key});

  @override
  State<PodsPage> createState() => _PodsPageState();
}

class _PodsPageState extends State<PodsPage> {
  Widget _buildTitleActions() {
    return Row(
      spacing: 5.0,
      children: [
        SelectableText(
          'pods_title'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Tooltip(
          message: 'pod_prune_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => prunePods(context),
            icon: Icon(Symbols.delete),
            label: Text('pod_prune_label'.tr()),
          ),
        ),
        Tooltip(
          message: 'pod_create_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/pod/create'),
            icon: Icon(Symbols.motion_play),
            label: Text('pod_create_label'.tr()),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ContainerUsage>? containers =
        context.watch<DiskUsageState>().containers;
    if (containers == null) {
      return EngineNotFound(title: 'pods_title'.tr());
    }
    return Column(
      children: [
        _buildTitleActions(),
        PodList(
          containers: containers,
        ),
      ],
    );
  }
}
