import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/checkbox_state.dart';
import 'package:pocker/core/widgets/popup_dialog.dart';
import 'package:pocker/core/widgets/table_header_with_sort.dart';
import 'package:pocker/services/podman.dart';
import 'package:pocker/services/system/model/volume_usage.dart';
import 'package:pocker/services/volume/model/volume_summary.dart';

import 'volume_list_row.dart';

class VolumeList extends StatefulWidget {
  final List<VolumeUsage> volumes;

  const VolumeList({
    super.key,
    required this.volumes,
  });

  @override
  State<VolumeList> createState() => _VolumeListState();
}

class _VolumeListState extends State<VolumeList> {
  List<VolumeUsage> _displayList = [];

  int _selectedCount = 0;
  Map<String, VolumeSummary> _volumeSummary = {};
  Map<String, CheckBoxState> _isCheckedVolumes = {};

  String _filter = '';
  String _sortColumn = '';
  SortStyle _sortStyle = SortStyle.none;

  bool _getHeaderCheckboxDisabled() {
    return _displayList
        .every((vol) => _isCheckedVolumes[vol.volumeName]!.disabled);
  }

  bool? _getHeaderCheckboxState() {
    if (_displayList.isEmpty) {
      return false;
    }
    if (_displayList.every((vol) =>
        _isCheckedVolumes[vol.volumeName]!.disabled ||
        _isCheckedVolumes[vol.volumeName]!.value)) {
      return true;
    }
    if (_displayList
        .every((vol) => !_isCheckedVolumes[vol.volumeName]!.value)) {
      return false;
    }
    return null;
  }

  void _toggleAllCheckboxes(bool? value) {
    setState(() {
      for (final vol in _displayList) {
        if (!_isCheckedVolumes[vol.volumeName]!.disabled) {
          _isCheckedVolumes[vol.volumeName]!.value = value ?? false;
        }
      }
      _selectedCount = _displayList
          .where((vol) => _isCheckedVolumes[vol.volumeName]!.value)
          .toList()
          .length;
    });
  }

  void _toggleRowCheckbox(VolumeUsage volume, bool? value) {
    setState(() {
      _isCheckedVolumes[volume.volumeName]!.value = value ?? false;
      _selectedCount = _displayList
          .where((vol) => _isCheckedVolumes[vol.volumeName]!.value)
          .toList()
          .length;
    });
  }

  void _toggleColumnSort(String column, SortStyle? sort) {
    _sortColumn = column;
    _sortStyle =
        SortStyle.values[(_sortStyle.index + 1) % SortStyle.values.length];
    if (_sortStyle.index == 0) {
      _sortStyle = SortStyle.values[1];
    }
    //
    setState(() {
      _sortList(_displayList);
    });
  }

  Future<void> _deleteCheckedVolumes() async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return PopupDialog.confirm(
          title: 'confirm_title'.tr(),
          content: 'volume_delete_content'.plural(_selectedCount),
          yesLabel: 'yes'.tr(),
          noLabel: 'cancel'.tr(),
        );
      },
    );
    if (result == true) {
      final podman = await Podman.getInstance();
      if (podman != null) {
        _isCheckedVolumes.forEach((name, state) async {
          if (state.value) {
            await podman.volume.removeVolume(name: name);
          }
        });
      }
    }
  }

  Widget _buildSearchRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
      child: Row(
        spacing: 5.0,
        children: [
          SizedBox(
            width: 300.0,
            child: TextField(
              onChanged: (value) {
                _filter = value.trim();
                _refreshList();
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Symbols.search),
                hintText: 'volume_search_hint'.tr(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          _selectedCount > 0
              ? Tooltip(
                  message: 'item_delete_tooltip'.plural(_selectedCount),
                  waitDuration: Duration(seconds: 2),
                  child: FilledButton(
                    onPressed: () => _deleteCheckedVolumes(),
                    child: Icon(Symbols.delete, fill: 0),
                  ),
                )
              : SizedBox.shrink(),
          _selectedCount > 0
              ? SelectableText('item_select_label'.plural(_selectedCount))
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    final disabled = _getHeaderCheckboxDisabled();
    return Row(
      children: [
        SizedBox(
          width: 20.0,
        ),
        SizedBox(
          width: 50.0,
          child: Checkbox(
            tristate: true,
            value: disabled ? null : _getHeaderCheckboxState(),
            onChanged: disabled ? null : _toggleAllCheckboxes,
          ),
        ),
        SizedBox(
          width: 90.0,
          child: TableHeaderWithSort(
            label: 'table_header_label_status'.tr(),
            sort: _sortColumn == 'STATUS' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('STATUS', value),
          ),
        ),
        Expanded(
          child: TableHeaderWithSort(
            label: 'table_header_label_name'.tr(),
            sort: _sortColumn == 'NAME' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('NAME', value),
          ),
        ),
        SizedBox(
          width: 100.0,
          child: TableHeaderWithSort(
            label: 'table_header_label_age'.tr(),
            sort: _sortColumn == 'AGE' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('AGE', value),
          ),
        ),
        SizedBox(
          width: 100.0,
          child: TableHeaderWithSort(
            label: 'table_header_label_size'.tr(),
            sort: _sortColumn == 'SIZE' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('SIZE', value),
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Center(
            child: Text(
              'table_header_label_actions'.tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  void _sortList(List<VolumeUsage> displayList) {
    switch (_sortColumn) {
      case 'STATUS':
        displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.links.compareTo(b.links);
          } else {
            return b.links.compareTo(a.links);
          }
        });
      case 'NAME':
        displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.volumeName.compareTo(b.volumeName);
          } else {
            return b.volumeName.compareTo(a.volumeName);
          }
        });
      case 'AGE':
        displayList.sort((a, b) {
          final aa = _volumeSummary[a.volumeName];
          final bb = _volumeSummary[b.volumeName];
          if (aa == null || bb == null) {
            return 0;
          }
          if (_sortStyle == SortStyle.ascending) {
            return bb.createdAt.compareTo(aa.createdAt);
          } else {
            return aa.createdAt.compareTo(bb.createdAt);
          }
        });
      case 'SIZE':
        displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.size.compareTo(b.size);
          } else {
            return b.size.compareTo(a.size);
          }
        });
    }
  }

  void _requestSummary() async {
    final podman = await Podman.getInstance();
    if (podman == null) {
      return;
    }
    //
    final Map<String, VolumeSummary> volumeSummary = {};
    final volumes = await podman.volume.listVolumes();
    for (final vol in volumes) {
      volumeSummary[vol.name] = vol;
    }
    //
    setState(() {
      _volumeSummary = volumeSummary;
    });
  }

  void _refreshList() {
    var displayList = widget.volumes;
    // Filter
    if (_filter != '') {
      displayList = displayList.where((vol) {
        return vol.volumeName.contains(_filter);
      }).toList();
    }
    // Sort
    if (_sortColumn != '') {
      _sortList(displayList);
    }
    // Checked
    final isCheckedVolumes = <String, CheckBoxState>{};
    for (final vol in displayList) {
      final checked = _isCheckedVolumes[vol.volumeName] ??
          CheckBoxState.init(disabled: vol.links > 0);
      if (vol.links > 0 && !checked.disabled) {
        isCheckedVolumes[vol.volumeName] = CheckBoxState.init(disabled: true);
      } else if (vol.links == 0 && checked.disabled) {
        isCheckedVolumes[vol.volumeName] = CheckBoxState.init(disabled: false);
      } else {
        isCheckedVolumes[vol.volumeName] = checked;
      }
    }
    //
    setState(() {
      _displayList = displayList;
      _isCheckedVolumes = isCheckedVolumes;
      _selectedCount = _displayList
          .where((vol) => _isCheckedVolumes[vol.volumeName]!.value)
          .toList()
          .length;
    });
    //
    _requestSummary();
  }

  @override
  void initState() {
    super.initState();
    //
    if (mounted) {
      _refreshList();
    }
  }

  @override
  void didUpdateWidget(covariant VolumeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    //
    if (!const DeepCollectionEquality()
        .equals(widget.volumes, oldWidget.volumes)) {
      _refreshList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _buildSearchRow(context),
          _buildTableHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _displayList.length,
                    itemBuilder: (context, index) {
                      final volume = _displayList[index];
                      return VolumeListRow(
                        volume: volume,
                        summary: _volumeSummary[volume.volumeName],
                        checked: _isCheckedVolumes[volume.volumeName]?.value ??
                            false,
                        onSelected: (value) {
                          _toggleRowCheckbox(volume, value);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
