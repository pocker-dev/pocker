import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/engine_not_found.dart';
import 'package:pocker/providers/disk_usage_state.dart';
import 'package:pocker/services/system/model/volume_usage.dart';
import 'package:provider/provider.dart';

import 'utils/prune_volumes.dart';
import 'widgets/volume_list.dart';

class VolumesPage extends StatefulWidget {
  const VolumesPage({super.key});

  @override
  State<VolumesPage> createState() => _VolumesPageState();
}

class _VolumesPageState extends State<VolumesPage> {
  Widget _buildTitleActions() {
    return Row(
      spacing: 5.0,
      children: [
        SelectableText(
          'volumes_title'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Tooltip(
          message: 'volume_prune_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => pruneVolumes(context),
            icon: Icon(Symbols.delete),
            label: Text('volume_prune_label'.tr()),
          ),
        ),
        // Tooltip(
        //   message: 'volume_gather_tooltip'.tr(),
        //   waitDuration: Duration(seconds: 2),
        //   child: FilledButton.icon(
        //     onPressed: () => {},
        //     icon: Icon(Symbols.cleaning_services),
        //     label: Text('volume_gather_label'.tr()),
        //   ),
        // ),
        Tooltip(
          message: 'volume_create_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/volume/create'),
            icon: Icon(Symbols.add_circle),
            label: Text('volume_create_label'.tr()),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<VolumeUsage>? volumes = context.watch<DiskUsageState>().volumes;
    if (volumes == null) {
      return EngineNotFound(title: 'volumes_title'.tr());
    }
    return Column(
      children: [
        _buildTitleActions(),
        VolumeList(
          volumes: volumes,
        ),
      ],
    );
  }
}
