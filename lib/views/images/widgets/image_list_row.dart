import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/dropdown_icon_button.dart';
import 'package:pocker/core/widgets/status_icon.dart';
import 'package:pocker/services/image/model/image_summary.dart';
import 'package:pocker/services/system/model/image_usage.dart';
import 'package:pocker/views/images/utils/delete_image.dart';

import 'image_edit_dialog.dart';
import 'image_list_cell_name.dart';
import 'image_list_cell_tag.dart';

class ImageListRow extends StatefulWidget {
  final ImageUsage image;
  final ImageSummary? summary;
  final bool checked;
  final ValueChanged<bool?> onSelected;

  const ImageListRow({
    super.key,
    required this.image,
    this.summary,
    required this.checked,
    required this.onSelected,
  });

  @override
  State<ImageListRow> createState() => _ImageListRowState();
}

class _ImageListRowState extends State<ImageListRow> {
  bool _deleting = false;

  void _dispatchActions(BuildContext context, int index) {
    switch (index) {
      case 0:
        print('push ${widget.image.name}');
      case 1:
        showDialog(
          context: context,
          builder: (context) => ImageEditDialog(
            id: widget.image.imageID,
            name: widget.image.name,
          ),
        );
      case 2:
        Navigator.pushNamed(
          context,
          '/image/detail',
          arguments: RouteArgument(
            id: widget.image.imageID,
            name: widget.image.name,
            tabIndex: 1,
          ),
        );
      case 3:
        Navigator.pushNamed(
          context,
          '/image/save',
          arguments: [
            RouteArgument(
              id: widget.image.imageID,
              name: widget.image.name,
            ),
          ],
        );
    }
  }

  List<PopupMenuItem<int>> _buildActionMenu() {
    return [
      PopupMenuItem(
        value: 0,
        child: Row(
          children: [
            Icon(Symbols.cloud_upload, fill: 0, size: 20.0),
            SizedBox(width: 10.0),
            Text('image_table_action_menu_push'.tr()),
          ],
        ),
      ),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: [
            Icon(Symbols.edit_square, fill: 0, size: 20.0),
            SizedBox(width: 10.0),
            Text('image_table_action_menu_edit'.tr()),
          ],
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Row(
          children: [
            Icon(Symbols.history, fill: 0, size: 20.0),
            SizedBox(width: 10.0),
            Text('image_table_action_menu_history'.tr()),
          ],
        ),
      ),
      PopupMenuItem(
        value: 3,
        child: Row(
          children: [
            Icon(Symbols.save, fill: 0, size: 20.0),
            SizedBox(width: 10.0),
            Text('image_table_action_menu_save'.tr()),
          ],
        ),
      ),
    ];
  }

  @override
  void didUpdateWidget(covariant ImageListRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    //
    if (widget.image.imageID != oldWidget.image.imageID && _deleting) {
      setState(() {
        _deleting = false;
      });
    }
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
                  value: widget.checked,
                  onChanged: widget.image.containers > 0
                      ? null
                      : (value) => widget.onSelected(value),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Center(
                  child: StatusIcon(
                    Symbols.stacks,
                    status: widget.image.containers > 0 ? 1 : 0,
                    tooltip: widget.image.containers > 0
                        ? 'table_status_icon_tooltip_used'.tr()
                        : 'table_status_icon_tooltip_unused'.tr(),
                  ),
                ),
              ),
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/image/detail',
                      arguments: RouteArgument(
                        id: widget.image.imageID,
                        name: widget.image.name,
                      ),
                    ),
                    child: ImageListCellName(image: widget.image),
                  ),
                ),
              ),
              SizedBox(
                width: 100.0,
                child: ImageListCellTag(
                  widget.summary?.arch ?? 'N/A',
                ),
              ),
              SizedBox(
                width: 100.0,
                child: SelectableText(
                  StringBeautify.formatDateTimeElapsed(widget.image.created),
                ),
              ),
              SizedBox(
                width: 100.0,
                child: SelectableText(
                  StringBeautify.formatStorageSize(widget.image.size),
                ),
              ),
              SizedBox(
                width: 150.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Tooltip(
                      message: 'image_table_action_run'.tr(),
                      waitDuration: Duration(seconds: 2),
                      child: IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/image/run',
                          arguments: RouteArgument(
                            id: widget.image.imageID,
                            name: widget.image.name,
                          ),
                        ),
                        icon: Icon(Symbols.play_arrow, fill: 1),
                      ),
                    ),
                    Tooltip(
                      message: 'image_table_action_delete'.tr(),
                      waitDuration: Duration(seconds: 2),
                      child: IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: _deleting || widget.image.containers > 0
                            ? null
                            : () => deleteImage(
                                  context,
                                  id: widget.image.imageID,
                                  name: widget.image.name,
                                  onConfirm: () {
                                    setState(() {
                                      _deleting = true;
                                    });
                                  },
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
