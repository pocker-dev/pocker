import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/json.dart' as highlight_json;
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/detail_page_layout.dart';
import 'package:pocker/core/widgets/detail_summary_row.dart';
import 'package:pocker/core/widgets/highlight.dart';
import 'package:pocker/core/widgets/status_icon.dart';
import 'package:pocker/providers/disk_usage_state.dart';
import 'package:pocker/services/podman.dart';
import 'package:pocker/services/system/model/volume_usage.dart';
import 'package:pocker/services/volume/model/volume_inspect.dart';
import 'package:pocker/views/volumes/utils/delete_volume.dart';
import 'package:provider/provider.dart';

class VolumeDetailPage extends StatefulWidget {
  final String name;

  const VolumeDetailPage({super.key, required this.name});

  @override
  State<VolumeDetailPage> createState() => _VolumeDetailPageState();
}

class _VolumeDetailPageState extends State<VolumeDetailPage> {
  late VolumeInspect _inspect;
  bool _inspectLoading = true;

  void _requestInspectData() async {
    final podman = await Podman.getInstance();
    if (podman == null) return;
    //
    final inspect = await podman.volume.inspectVolume(
      name: widget.name,
    );
    if (mounted) {
      setState(() {
        _inspect = inspect;
        _inspectLoading = false;
      });
    }
  }

  Widget _buildSummary(BuildContext context, VolumeUsage? usage) {
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailSummaryRow(name: 'Name', value: widget.name),
                  DetailSummaryRow(
                    name: 'Size',
                    value: usage != null
                        ? StringBeautify.formatStorageSize(usage.size)
                        : 'N/A',
                  ),
                  DetailSummaryRow(
                    name: 'Age',
                    value: StringBeautify.formatDateTimeElapsed(
                      DateTime.parse(_inspect.createdAt),
                    ),
                  ),
                  DetailSummaryRow(
                    name: 'Created',
                    value: _inspect.createdAt.toString(),
                  ),
                  DetailSummaryRow(
                    name: 'Status',
                    value: usage != null && usage.links > 0
                        ? 'table_status_icon_tooltip_used'.tr().toLowerCase()
                        : 'table_status_icon_tooltip_unused'.tr().toLowerCase(),
                  ),
                  DetailSummaryRow(
                    name: 'Mount Point',
                    value: _inspect.mountpoint,
                  ),
                  DetailSummaryRow(name: 'Scope', value: _inspect.scope),
                  DetailSummaryRow(name: 'Driver', value: _inspect.driver),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _requestInspectData();
  }

  @override
  Widget build(BuildContext context) {
    if (_inspectLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final usage = Provider.of<DiskUsageState>(context)
        .volumes
        ?.firstWhereOrNull((vol) => vol.volumeName == widget.name);
    return DetailPageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'volumes_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'volume_details_title'.tr()),
      ],
      icon: StatusIcon(
        Symbols.database,
        size: 30.0,
        status: usage != null && usage.links > 0 ? 1 : 0,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            _inspect.shortName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      subtitle: SelectableText(
        usage != null ? StringBeautify.formatStorageSize(usage.size) : 'N/A',
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      actions: [
        Tooltip(
          message: 'volume_delete_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: usage != null && usage.links > 0
                ? null
                : () => deleteVolume(
                      context,
                      _inspect.name,
                      onSuccess: () => Navigator.of(context).pop(),
                    ),
            child: Icon(Symbols.delete, fill: 0),
          ),
        ),
      ],
      tabs: [
        TabInfo(
          name: 'detail_tab_summary'.tr(),
          widget: _buildSummary(context, usage),
        ),
        TabInfo(
          name: 'detail_tab_inspect'.tr(),
          widget: Highlight(
            language: highlight_json.json,
            text: StringBeautify.formatJSON(json.encode(_inspect.toJson())),
          ),
        ),
      ],
    );
  }
}
