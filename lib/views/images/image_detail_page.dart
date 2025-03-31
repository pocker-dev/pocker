import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/dockerfile.dart' as highlight_docker;
import 'package:highlight/languages/json.dart' as highlight_json;
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/detail_page_layout.dart';
import 'package:pocker/core/widgets/detail_summary_row.dart';
import 'package:pocker/core/widgets/highlight.dart';
import 'package:pocker/core/widgets/status_icon.dart';
import 'package:pocker/providers/disk_usage_state.dart';
import 'package:pocker/services/image/model/image_inspect.dart';
import 'package:pocker/services/podman.dart';
import 'package:provider/provider.dart';

import 'utils/delete_image.dart';
import 'widgets/image_edit_dialog.dart';

class ImageDetailPage extends StatefulWidget {
  final RouteArgument argument;

  const ImageDetailPage({
    super.key,
    required this.argument,
  });

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  late List<String> _repoTags;
  late ImageInspect _inspect;
  late List<String> _history;
  bool _inspectLoading = true;
  bool _historyLoading = true;

  void _requestInspectData() async {
    final podman = await Podman.getInstance();
    if (podman == null) return;
    //
    final inspect = await podman.image.inspectImage(
      name: widget.argument.identity,
    );
    if (mounted) {
      setState(() {
        _inspect = inspect;
        _inspectLoading = false;
      });
    }
  }

  void _requestHistoryData() async {
    final podman = await Podman.getInstance();
    if (podman == null) return;
    //
    final history = await podman.image.imageHistory(
      name: widget.argument.identity,
    );
    if (mounted) {
      setState(() {
        _history = history.map((info) => info.createdBy).toList();
        _historyLoading = false;
      });
    }
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailSummaryRow(
                    name: 'Name',
                    value: _repoTags[0],
                  ),
                  DetailSummaryRow(
                    name: 'Tag',
                    value: _repoTags[1],
                  ),
                  DetailSummaryRow(
                    name: 'ID',
                    value: _inspect.id,
                  ),
                  DetailSummaryRow(
                    name: 'Size',
                    value: StringBeautify.formatStorageSize(_inspect.size),
                  ),
                  DetailSummaryRow(
                    name: 'Age',
                    value: StringBeautify.formatDateTimeElapsed(
                      DateTime.parse(_inspect.created),
                    ),
                  ),
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
    _repoTags = widget.argument.imageRepositoryTag;
    _requestInspectData();
    _requestHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    if (_inspectLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final usage = Provider.of<DiskUsageState>(context).images?.firstWhereOrNull(
        (img) => widget.argument.name != null
            ? widget.argument.name == img.name
            : widget.argument.id == img.imageID);
    return DetailPageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'images_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'image_details_title'.tr()),
      ],
      icon: StatusIcon(
        Symbols.stacks,
        size: 30.0,
        status: usage != null && usage.containers > 0 ? 1 : 0,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SelectableText(
            _repoTags[0],
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SelectableText(
            _inspect.shortId,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      subtitle: _repoTags[1] == ''
          ? null
          : SelectableText(
              _repoTags[1],
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
      actions: [
        Tooltip(
          message: 'image_run_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: () => Navigator.pushNamed(
              context,
              '/image/run',
              arguments: RouteArgument(
                id: _inspect.id,
                name: widget.argument.name,
              ),
            ),
            child: Icon(Symbols.play_arrow, fill: 1),
          ),
        ),
        Tooltip(
          message: 'image_delete_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: usage != null && usage.containers > 0
                ? null
                : () => deleteImage(
                      context,
                      id: _inspect.id,
                      name: widget.argument.name,
                      onSuccess: () => Navigator.of(context).pop(),
                    ),
            child: Icon(Symbols.delete, fill: 0),
          ),
        ),
        Tooltip(
          message: 'image_push_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: () {},
            child: Icon(Symbols.cloud_upload, fill: 0),
          ),
        ),
        Tooltip(
          message: 'image_edit_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: () async {
              final bool? result = await showDialog<bool>(
                context: context,
                builder: (context) => ImageEditDialog(
                  id: _inspect.id,
                  name: widget.argument.name,
                ),
              );
              if (result == true && context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: Icon(Symbols.edit_square, fill: 0),
          ),
        ),
        Tooltip(
          message: 'image_save_button_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton(
            onPressed: () => Navigator.pushNamed(
              context,
              '/image/save',
              arguments: [
                widget.argument,
              ],
            ),
            child: Icon(Symbols.save, fill: 0),
          ),
        ),
      ],
      tabs: [
        TabInfo(
          name: 'detail_tab_summary'.tr(),
          widget: _buildSummary(context),
        ),
        TabInfo(
          name: 'detail_tab_history'.tr(),
          widget: _historyLoading
              ? Center(child: CircularProgressIndicator())
              : Highlight(
                  language: highlight_docker.dockerfile,
                  text: _history.join('\n'),
                ),
        ),
        TabInfo(
          name: 'detail_tab_inspect'.tr(),
          widget: Highlight(
            language: highlight_json.json,
            text: StringBeautify.formatJSON(json.encode(_inspect.toJson())),
          ),
        ),
      ],
      initialIndex: widget.argument.tabIndex,
    );
  }
}
