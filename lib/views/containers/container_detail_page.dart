import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/json.dart' as highlight_json;
import 'package:highlight/languages/shell.dart' as highlight_shell;
import 'package:highlight/languages/yaml.dart' as highlight_yaml;
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/circular_progress.dart';
import 'package:pocker/core/widgets/detail_page_layout.dart';
import 'package:pocker/core/widgets/detail_summary_row.dart';
import 'package:pocker/core/widgets/highlight.dart';
import 'package:pocker/core/widgets/status_icon.dart';
import 'package:pocker/services/container/model/container_inspect.dart';
import 'package:pocker/services/container/model/container_stats.dart';
import 'package:pocker/services/podman.dart';

import 'utils/delete_container.dart';
import 'utils/operate_container.dart';

class ContainerDetailPage extends StatefulWidget {
  final RouteArgument argument;

  const ContainerDetailPage({
    super.key,
    required this.argument,
  });

  @override
  State<ContainerDetailPage> createState() => _ContainerDetailPageState();
}

class _ContainerDetailPageState extends State<ContainerDetailPage> {
  late ContainerInspect _inspect;
  ContainerStats? _stats;
  List<String> _logs = [];
  String? _yaml;
  bool _inspectLoading = true;

  void _requestLogs() async {
    final podman = await Podman.getInstance();
    if (podman == null) return;
    //
    await podman.container.tailContainerLog(
      name: widget.argument.identity,
      onData: (lines) {
        if (mounted) {
          setState(() {
            _logs.addAll(lines);
          });
        }
      },
    );
  }

  void _requestStats() async {
    final podman = await Podman.getInstance();
    if (podman == null) return;
    //
    await podman.container.getContainerStats(
      name: widget.argument.identity,
      onData: (stats) {
        if (mounted) {
          setState(() {
            _stats = stats.last;
          });
        }
      },
    );
  }

  void _requestInspectData() async {
    final podman = await Podman.getInstance();
    if (podman == null) return;
    //
    final inspect = await podman.container.inspectContainer(
      name: widget.argument.identity,
    );
    if (mounted) {
      setState(() {
        _inspect = inspect;
        _inspectLoading = false;
      });
    }
    if (inspect.isStandalone) {
      _requestYAML();
    }
    if (inspect.state.status.toLowerCase() == 'running') {
      _requestStats();
    } else {
      setState(() {
        _stats = null;
      });
    }
  }

  void _requestYAML() async {
    final podman = await Podman.getInstance();
    if (podman == null) return;
    //
    final yaml = await podman.pod.generateYAML(
      name: widget.argument.identity,
    );
    if (mounted) {
      setState(() {
        _yaml = yaml;
      });
    }
  }

  Widget _buildSummaryDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailSummaryRow(
            name: 'Name',
            value: _inspect.name.substring(1),
          ),
          DetailSummaryRow(
            name: 'ID',
            value: _inspect.id,
          ),
          DetailSummaryRow(
            name: 'Image',
            value: _inspect.config.image ?? _inspect.image.substring(7),
          ),
          DetailSummaryRow(
            name: 'Command',
            value: _inspect.config.cmd != null
                ? _inspect.config.cmd!.join(' ')
                : '',
          ),
          DetailSummaryRow(
            name: 'Ports',
            value: _inspect.ports,
          ),
          DetailSummaryRow(
            name: 'State',
            value: _inspect.state.status,
          ),
          DetailSummaryRow(
            name: 'Uptime',
            value: _inspect.state.status.toLowerCase() != 'running'
                ? 'N/A'
                : StringBeautify.formatDateTimeElapsed(
                    _inspect.state.startedAt!),
          ),
          DetailSummaryRow(
            name: 'Started at	',
            value: _inspect.state.startedAt.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryGroup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailSummaryRow(
            name: 'Name',
            value: _inspect.groupName,
          ),
          DetailSummaryRow(
            name: 'Type',
            value: _inspect.groupType,
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              'Details',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildSummaryDetails(context),
            SelectableText(
              'Group',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildSummaryGroup(context),
          ],
        ),
      ),
    );
  }

  void _refresh() {
    _requestInspectData();
    _requestLogs();
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    if (_inspectLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return DetailPageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'containers_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'pod_details_title'.tr()),
      ],
      icon: StatusIcon(
        Symbols.deployed_code,
        iconFill: false,
        size: 30.0,
        status: _inspect.state.status.toLowerCase() == 'exited'
            ? 0
            : _inspect.state.status.toLowerCase() == 'running'
                ? 1
                : 2,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            _inspect.name.substring(1),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      subtitle: SelectableText(
        _inspect.config.image ?? '<TODO>',
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      actions: [
        if (_inspect.state.status.toLowerCase() == 'running')
          Tooltip(
            message: 'container_stop_button_tooltip'.tr(),
            waitDuration: Duration(seconds: 2),
            child: FilledButton(
              onPressed: () async {
                await stopContainer(widget.argument.identity);
                _refresh();
              },
              child: Icon(Symbols.stop, fill: 1),
            ),
          )
        else
          Tooltip(
            message: 'container_start_button_tooltip'.tr(),
            waitDuration: Duration(seconds: 2),
            child: FilledButton(
              onPressed: () {
                startContainer(widget.argument.identity);
                _refresh();
              },
              child: Icon(Symbols.play_arrow, fill: 1),
            ),
          ),
        Tooltip(
          message: 'container_delete_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: () => deleteContainer(
              context,
              id: widget.argument.id!,
              name: widget.argument.name,
              onSuccess: () => Navigator.of(context).pop(),
            ),
            child: Icon(Symbols.delete, fill: 0),
          ),
        ),
        Tooltip(
          message: 'container_restart_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: () {
              restartContainer(widget.argument.identity);
              _refresh();
            },
            child: Icon(Symbols.restart_alt, fill: 0),
          ),
        ),
      ],
      tabs: [
        TabInfo(
          name: 'detail_tab_summary'.tr(),
          widget: _buildSummary(context),
        ),
        TabInfo(
          name: 'detail_tab_logs'.tr(),
          widget: Highlight(
            language: highlight_shell.shell,
            text: _logs.join(''),
          ),
        ),
        TabInfo(
          name: 'detail_tab_inspect'.tr(),
          widget: Highlight(
            language: highlight_json.json,
            text: StringBeautify.formatJSON(json.encode(_inspect.toJson())),
          ),
        ),
        if (_yaml != null)
          TabInfo(
            name: 'detail_tab_yaml'.tr(),
            widget: Highlight(
              language: highlight_yaml.yaml,
              text: _yaml!,
            ),
          ),
      ],
      monitor: _stats != null
          ? Row(
              children: [
                CircularProgress(
                  size: CircularProgressSize.small,
                  value: _stats!.cPU,
                  title: 'vCPUs',
                  subtitle: '${(_stats!.cPU * 100).toStringAsFixed(1)}%',
                  tooltip: 'container_vcpu_usage'.tr(args: [
                    (_stats!.cPU * 100).toStringAsFixed(0),
                  ]),
                ),
                SizedBox(width: 8.0),
                CircularProgress(
                  size: CircularProgressSize.small,
                  value: _stats!.memUsage / _stats!.memLimit,
                  title: 'Mem',
                  subtitle: StringBeautify.formatStorageSize(_stats!.memUsage),
                  tooltip: 'container_memory_usage'.tr(args: [
                    (_stats!.memUsage * 100 / _stats!.memLimit)
                        .toStringAsFixed(0),
                  ]),
                ),
                SizedBox(width: 8.0),
              ],
            )
          : null,
    );
  }
}
