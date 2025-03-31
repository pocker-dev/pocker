import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/json.dart' as highlight_json;
import 'package:highlight/languages/yaml.dart' as highlight_yaml;
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/detail_page_layout.dart';
import 'package:pocker/core/widgets/detail_summary_row.dart';
import 'package:pocker/core/widgets/highlight.dart';
import 'package:pocker/core/widgets/status_icon.dart';
import 'package:pocker/services/pod/model/pod_container_inspect.dart';
import 'package:pocker/services/pod/model/pod_inspect.dart';
import 'package:pocker/services/podman.dart';
import 'package:pocker/views/pods/utils/operate_pod.dart';

import 'utils/delete_pod.dart';

class PodDetailPage extends StatefulWidget {
  final RouteArgument argument;

  const PodDetailPage({
    super.key,
    required this.argument,
  });

  @override
  State<PodDetailPage> createState() => _PodDetailPageState();
}

class _PodDetailPageState extends State<PodDetailPage> {
  late PodInspect _inspect;
  late String _yaml;
  bool _inspectLoading = true;
  bool _yamlLoading = true;

  void _requestInspectData() async {
    final podman = await Podman.getInstance();
    if (podman == null) return;
    //
    final inspect = await podman.pod.inspectPod(
      name: widget.argument.identity,
    );
    if (mounted) {
      setState(() {
        _inspect = inspect;
        _inspectLoading = false;
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
        _yamlLoading = false;
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
            value: _inspect.name,
          ),
          DetailSummaryRow(
            name: 'ID',
            value: _inspect.id,
          ),
          DetailSummaryRow(
            name: 'Created',
            value: _inspect.created.toString(),
          ),
          DetailSummaryRow(
            name: 'Age',
            value: StringBeautify.formatDateTimeElapsed(
              _inspect.created,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer(BuildContext context, PodContainerInspect container) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SelectableText(
                container.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          DetailSummaryRow(
            name: 'ID',
            value: container.id,
          ),
          DetailSummaryRow(
            name: 'Status',
            value: container.state.toLowerCase(),
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
              'Pod Status',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailSummaryRow(
                    name: 'Status',
                    value: _inspect.state.toLowerCase(),
                  ),
                ],
              ),
            ),
            SelectableText(
              'Containers',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (final container in _inspect.containers)
              _buildContainer(context, container),
          ],
        ),
      ),
    );
  }

  void _refresh() {
    _requestYAML();
    _requestInspectData();
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    if (_inspectLoading || _yamlLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return DetailPageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'pods_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'pod_details_title'.tr()),
      ],
      icon: StatusIcon(
        Symbols.grid_view,
        iconFill: false,
        size: 30.0,
        status: _inspect.state.toLowerCase() == 'exited'
            ? 0
            : _inspect.state.toLowerCase() == 'running'
                ? 1
                : 2,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            _inspect.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      subtitle: SelectableText(
        _inspect.shortId,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      actions: [
        if (_inspect.state.toLowerCase() == 'running')
          Tooltip(
            message: 'pod_stop_button_tooltip'.tr(),
            waitDuration: Duration(seconds: 2),
            child: FilledButton(
              onPressed: () async {
                await stopPod(widget.argument.identity);
                _refresh();
              },
              child: Icon(Symbols.stop, fill: 1),
            ),
          )
        else
          Tooltip(
            message: 'pod_start_button_tooltip'.tr(),
            waitDuration: Duration(seconds: 2),
            child: FilledButton(
              onPressed: () {
                startPod(widget.argument.identity);
                _refresh();
              },
              child: Icon(Symbols.play_arrow, fill: 1),
            ),
          ),
        Tooltip(
          message: 'pod_delete_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: () => deletePod(
              context,
              id: widget.argument.id!,
              name: widget.argument.name,
              onSuccess: () => Navigator.of(context).pop(),
            ),
            child: Icon(Symbols.delete, fill: 0),
          ),
        ),
        Tooltip(
          message: 'pod_restart_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: () {
              restartPod(widget.argument.identity);
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
          widget: Text(''),
        ),
        TabInfo(
          name: 'detail_tab_inspect'.tr(),
          widget: Highlight(
            language: highlight_json.json,
            text: StringBeautify.formatJSON(json.encode(_inspect.toJson())),
          ),
        ),
        TabInfo(
          name: 'detail_tab_yaml'.tr(),
          widget: Highlight(
            language: highlight_yaml.yaml,
            text: _yaml,
          ),
        ),
      ],
      initialIndex: widget.argument.tabIndex,
    );
  }
}
