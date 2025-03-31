import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/dropdown_icon_button.dart';
import 'package:pocker/core/widgets/status_icon.dart';
import 'package:pocker/services/pod/model/pod_summary.dart';
import 'package:pocker/views/pods/utils/delete_pod.dart';
import 'package:pocker/views/pods/utils/operate_pod.dart';

import 'pod_list_cell_name.dart';
import 'pod_list_cell_tag.dart';

class PodListRow extends StatelessWidget {
  final PodSummary pod;
  final bool checked;
  final ValueChanged<bool?> onSelected;

  const PodListRow({
    super.key,
    required this.pod,
    required this.checked,
    required this.onSelected,
  });

  void _dispatchActions(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(
          context,
          '/pod/detail',
          arguments: RouteArgument(
            id: pod.id,
            name: pod.name,
            tabIndex: 3,
          ),
        );
      case 1:
        restartPod(pod.id);
    }
  }

  List<PopupMenuItem<int>> _buildActionMenu() {
    return [
      PopupMenuItem(
        value: 0,
        child: Row(
          children: [
            Icon(Symbols.code_blocks, fill: 0, size: 20.0),
            SizedBox(width: 10.0),
            Text('pod_table_action_menu_generate'.tr()),
          ],
        ),
      ),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: [
            Icon(Symbols.restart_alt, fill: 0, size: 20.0),
            SizedBox(width: 10.0),
            Text('pod_table_action_menu_restart'.tr()),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              SizedBox(
                width: 50.0,
                child: Checkbox(
                  value: checked,
                  onChanged: (value) => onSelected(value),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Center(
                  child: StatusIcon(
                    Symbols.grid_view,
                    iconFill: false,
                    status: pod.status.toLowerCase() == 'exited'
                        ? 0
                        : pod.status.toLowerCase() == 'running'
                            ? 1
                            : 2,
                    tooltip: pod.status.toUpperCase(),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/pod/detail',
                      arguments: RouteArgument(
                        id: pod.id,
                        name: pod.name,
                      ),
                    ),
                    child: PodListCellName(info: pod),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: PodListCellTag(containers: pod.containers),
              ),
              SizedBox(
                width: 100.0,
                child: SelectableText(
                  StringBeautify.formatDateTimeElapsed(pod.created),
                ),
              ),
              SizedBox(
                width: 150.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (pod.status.toLowerCase() == 'running')
                      Tooltip(
                        message: 'pod_table_action_stop'.tr(),
                        waitDuration: Duration(seconds: 2),
                        child: IconButton(
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () => stopPod(pod.id),
                          icon: Icon(Symbols.stop, fill: 1),
                        ),
                      )
                    else
                      Tooltip(
                        message: 'pod_table_action_start'.tr(),
                        waitDuration: Duration(seconds: 2),
                        child: IconButton(
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () => startPod(pod.id),
                          icon: Icon(Symbols.play_arrow, fill: 1),
                        ),
                      ),
                    Tooltip(
                      message: 'pod_table_action_delete'.tr(),
                      waitDuration: Duration(seconds: 2),
                      child: IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => deletePod(
                          context,
                          id: pod.id,
                          name: pod.name,
                        ),
                        icon: Icon(Symbols.delete, fill: 1),
                      ),
                    ),
                    DropdownIconButton(
                      icon: Icon(
                        Symbols.more_vert,
                        fill: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      items: _buildActionMenu(),
                      onSelected: (int index) =>
                          _dispatchActions(context, index),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
