import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/dropdown_icon_button.dart';
import 'package:pocker/core/widgets/status_icon.dart';
import 'package:pocker/services/container/model/container_summary.dart';
import 'package:pocker/views/containers/model/container_group.dart';
import 'package:pocker/views/containers/utils/operate_container.dart';
import 'package:pocker/views/pods/pod_detail_page.dart';
import 'package:pocker/views/pods/utils/operate_pod.dart';

import 'container_list_cell_container_name.dart';
import 'container_list_cell_pod_name.dart';
import 'container_list_row_more.dart';

typedef ContainerStatusChanged = void Function(
  ContainerSummary container,
  bool? value,
);

class ContainerListRow extends StatefulWidget {
  final ContainerGroup group;

  final Map<String, bool> checked;
  final ValueChanged<bool?> onSelected;
  final ContainerStatusChanged onContainerSelected;

  const ContainerListRow({
    super.key,
    required this.group,
    required this.checked,
    required this.onSelected,
    required this.onContainerSelected,
  });

  @override
  State<ContainerListRow> createState() => _ContainerListRowState();
}

class _ContainerListRowState extends State<ContainerListRow> {
  bool _collapsed = true;

  void _dispatchActions(BuildContext context, int index) {
    switch (index) {}
  }

  /// style
  /// 1: standalone
  /// 2: compose
  /// 3: container
  List<PopupMenuItem<int>> _buildActionMenu(int style) {
    return [
      if (style != 2)
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(Symbols.description, fill: 0, size: 20.0),
              SizedBox(width: 10.0),
              Text('container_table_action_open_logs'.tr()),
            ],
          ),
        ),
      if (style == 2)
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Symbols.restart_alt, fill: 0, size: 20.0),
              SizedBox(width: 10.0),
              Text('container_table_action_restart_compose'.tr()),
            ],
          ),
        ),
      if (style == 3)
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Symbols.restart_alt, fill: 0, size: 20.0),
              SizedBox(width: 10.0),
              Text('container_table_action_restart_container'.tr()),
            ],
          ),
        ),
      if (style != 2)
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Symbols.download, fill: 0, size: 20.0),
              SizedBox(width: 10.0),
              Text('container_table_action_export_container'.tr()),
            ],
          ),
        ),
    ];
  }

  Widget _buildPodRow(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20.0,
          child: ContainerListRowMore(onTap: (val) {
            setState(() {
              _collapsed = val;
            });
          }),
        ),
        SizedBox(
          width: 50.0,
          child: Checkbox(
            value: widget.checked[widget.group.id] ?? false,
            onChanged: (value) => widget.onSelected(value),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Center(
            child: StatusIcon(
              Symbols.grid_view,
              iconFill: false,
              status: widget.group.status.toLowerCase() == 'exited'
                  ? 0
                  : widget.group.status.toLowerCase() == 'running'
                      ? 1
                      : 2,
              tooltip: widget.group.status.toUpperCase(),
            ),
          ),
        ),
        Expanded(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PodDetailPage(
                    argument: RouteArgument(
                      id: widget.group.id,
                      name: widget.group.name,
                    ),
                  ),
                ),
              ),
              child: ContainerListCellPodName(
                group: widget.group,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200.0,
        ),
        SizedBox(
          width: 100.0,
        ),
        //
        if (widget.group.isCompose())
          SizedBox(
            width: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.group.status.toLowerCase() == 'running')
                  Tooltip(
                    message: 'container_table_action_compose_stop'.tr(),
                    waitDuration: Duration(seconds: 2),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () => stopPod(widget.group.id),
                      icon: Icon(Symbols.stop, fill: 1),
                    ),
                  )
                else
                  Tooltip(
                    message: 'container_table_action_compose_start'.tr(),
                    waitDuration: Duration(seconds: 2),
                    child: IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () => startPod(widget.group.id),
                      icon: Icon(Symbols.play_arrow, fill: 1),
                    ),
                  ),
                Tooltip(
                  message: 'container_table_action_compose_delete'.tr(),
                  waitDuration: Duration(seconds: 2),
                  child: IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    icon: Icon(Symbols.delete, fill: 1),
                  ),
                ),
                DropdownIconButton(
                  icon: Icon(
                    Symbols.more_vert,
                    fill: 1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  items: _buildActionMenu(2),
                  onSelected: (int index) => _dispatchActions(context, index),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildContainerRow(
      BuildContext context, ContainerSummary container, bool isStandalone) {
    return Row(
      children: [
        SizedBox(
          width: 20.0,
        ),
        SizedBox(
          width: 50.0,
          child: Checkbox(
            value: widget.checked[container.id] ?? false,
            onChanged: (value) => widget.onContainerSelected(container, value),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Center(
            child: StatusIcon(
              Symbols.deployed_code,
              iconFill: false,
              status: container.state.toLowerCase() == 'exited'
                  ? 0
                  : container.state.toLowerCase() == 'running'
                      ? 1
                      : 2,
              tooltip: container.state.toUpperCase(),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                '/container/detail',
                arguments: RouteArgument(
                  id: container.id,
                  name: container.names[0],
                ),
              ),
              child: ContainerListCellContainerName(
                container: container,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: SelectableText(container.imageName),
        ),
        SizedBox(
          width: 100.0,
          child: container.state.toLowerCase() == 'running'
              ? SelectableText(
                  StringBeautify.formatTimestampElapsed(container.startedAt!),
                )
              : SizedBox.shrink(),
        ),
        SizedBox(
          width: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (container.state.toLowerCase() == 'running')
                Tooltip(
                  message: 'container_table_action_stop'.tr(),
                  waitDuration: Duration(seconds: 2),
                  child: IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () => stopContainer(container.id),
                    icon: Icon(Symbols.stop, fill: 1),
                  ),
                )
              else
                Tooltip(
                  message: 'container_table_action_start'.tr(),
                  waitDuration: Duration(seconds: 2),
                  child: IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () => startContainer(container.id),
                    icon: Icon(Symbols.play_arrow, fill: 1),
                  ),
                ),
              Tooltip(
                message: 'container_table_action_delete'.tr(),
                waitDuration: Duration(seconds: 2),
                child: IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {},
                  icon: Icon(Symbols.delete, fill: 1),
                ),
              ),
              DropdownIconButton(
                icon: Icon(
                  Symbols.more_vert,
                  fill: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                items: _buildActionMenu(isStandalone ? 1 : 3),
                onSelected: (int index) => _dispatchActions(context, index),
              ),
            ],
          ),
        ),
      ],
    );
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
          child: Column(
            spacing: 5.0,
            children: [
              if (widget.group.isStandalone())
                _buildContainerRow(context, widget.group.containers[0], true),
              if (!widget.group.isStandalone()) _buildPodRow(context),
              if (!widget.group.isStandalone() && !_collapsed)
                for (final container in widget.group.containers)
                  _buildContainerRow(context, container, false),
            ],
          ),
        ),
      ),
    );
  }
}
