import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/engine_not_found.dart';
import 'package:pocker/providers/disk_usage_state.dart';
import 'package:pocker/services/system/model/container_usage.dart';
import 'package:provider/provider.dart';

import 'utils/prune_containers.dart';
import 'widgets/container_list.dart';

class ContainersPage extends StatefulWidget {
  const ContainersPage({super.key});

  @override
  State<ContainersPage> createState() => _ContainersPageState();
}

class _ContainersPageState extends State<ContainersPage> {
  Widget _buildTitleActions() {
    return Row(
      spacing: 5.0,
      children: [
        SelectableText(
          'containers_title'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Tooltip(
          message: 'container_prune_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => pruneContainers(context),
            icon: Icon(Symbols.delete),
            label: Text('container_prune_label'.tr()),
          ),
        ),
        Tooltip(
          message: 'container_create_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/container/create'),
            icon: Icon(Symbols.add_circle),
            label: Text('container_create_label'.tr()),
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
      return EngineNotFound(title: 'containers_title'.tr());
    }
    return Column(
      children: [
        _buildTitleActions(),
        ContainerList(
          containers: containers,
        ),
      ],
    );
  }
}
