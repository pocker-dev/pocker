import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/string_beautify.dart';
import 'package:pocker/core/widgets/status_icon.dart';
import 'package:pocker/services/system/model/volume_usage.dart';
import 'package:pocker/services/volume/model/volume_summary.dart';
import 'package:pocker/views/volumes/utils/delete_volume.dart';

class VolumeListRow extends StatefulWidget {
  final VolumeUsage volume;
  final VolumeSummary? summary;
  final bool checked;
  final ValueChanged<bool?> onSelected;

  const VolumeListRow({
    super.key,
    required this.volume,
    this.summary,
    required this.checked,
    required this.onSelected,
  });

  @override
  State<VolumeListRow> createState() => _VolumeListRowState();
}

class _VolumeListRowState extends State<VolumeListRow> {
  bool _deleting = false;

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
                  onChanged: widget.volume.links > 0
                      ? null
                      : (value) => widget.onSelected(value),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Center(
                  child: StatusIcon(
                    Symbols.database,
                    status: widget.volume.links > 0 ? 1 : 0,
                    tooltip: widget.volume.links > 0
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
                      '/volume/detail',
                      arguments: widget.volume.volumeName,
                    ),
                    child: Text(widget.volume.shortName),
                  ),
                ),
              ),
              SizedBox(
                width: 100.0,
                child: SelectableText(widget.summary != null
                    ? StringBeautify.formatDateTimeElapsed(
                        widget.summary!.createdAt)
                    : 'N/A'),
              ),
              SizedBox(
                width: 100.0,
                child: SelectableText(
                  StringBeautify.formatStorageSize(widget.volume.size),
                ),
              ),
              SizedBox(
                width: 150.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Tooltip(
                      message: 'volume_table_action_delete'.tr(),
                      waitDuration: Duration(seconds: 2),
                      child: IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: _deleting || widget.volume.links > 0
                            ? null
                            : () => deleteVolume(
                                  context,
                                  widget.volume.volumeName,
                                  onConfirm: () {
                                    setState(() {
                                      _deleting = true;
                                    });
                                  },
                                ),
                        icon: Icon(Symbols.delete, fill: 1),
                      ),
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
