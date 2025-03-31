import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/popup_dialog.dart';
import 'package:pocker/core/widgets/table_header_with_sort.dart';
import 'package:pocker/services/pod/model/pod_summary.dart';
import 'package:pocker/services/podman.dart';
import 'package:pocker/services/system/model/container_usage.dart';

import 'pod_list_row.dart';

class PodList extends StatefulWidget {
  final List<ContainerUsage> containers;

  const PodList({
    super.key,
    required this.containers,
  });

  @override
  State<PodList> createState() => _PodListState();
}

class _PodListState extends State<PodList> {
  List<PodSummary> _displayList = [];

  int _selectedCount = 0;
  Map<String, bool> _isCheckedPods = {};

  String _filter = '';
  String _sortColumn = '';
  SortStyle _sortStyle = SortStyle.none;

  bool? _getHeaderCheckboxState() {
    if (_displayList.isEmpty) {
      return false;
    }
    if (_isCheckedPods.values.every((val) => val)) {
      return true;
    }
    if (_isCheckedPods.values.every((val) => !val)) {
      return false;
    }
    return null;
  }

  void _toggleAllCheckboxes(bool? value) {
    setState(() {
      _isCheckedPods.updateAll((key, val) => value ?? false);
      _selectedCount =
          _isCheckedPods.values.where((val) => val).toList().length;
    });
  }

  void _toggleRowCheckbox(PodSummary pod, bool? value) {
    setState(() {
      _isCheckedPods[pod.name] = value ?? false;
      _selectedCount =
          _isCheckedPods.values.where((val) => val).toList().length;
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

  Future<void> _deleteCheckedPods() async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return PopupDialog.confirm(
          title: 'confirm_title'.tr(),
          content: 'pod_delete_content'.plural(_selectedCount),
          yesLabel: 'yes'.tr(),
          noLabel: 'cancel'.tr(),
        );
      },
    );
    if (result == true) {
      final podman = await Podman.getInstance();
      if (podman != null) {
        _isCheckedPods.forEach((name, val) async {
          if (val) {
            await podman.pod.removePod(name: name);
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
                hintText: 'pod_search_hint'.tr(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          _selectedCount > 0
              ? Tooltip(
                  message: 'item_delete_tooltip'.plural(_selectedCount),
                  waitDuration: Duration(seconds: 2),
                  child: FilledButton(
                    onPressed: () => _deleteCheckedPods(),
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
    return Row(
      children: [
        SizedBox(
          width: 20.0,
        ),
        SizedBox(
          width: 50.0,
          child: Checkbox(
            tristate: true,
            value: _getHeaderCheckboxState(),
            onChanged: _toggleAllCheckboxes,
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
          flex: 3,
          child: TableHeaderWithSort(
            label: 'table_header_label_name'.tr(),
            sort: _sortColumn == 'NAME' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('NAME', value),
          ),
        ),
        Expanded(
          flex: 2,
          child: TableHeaderWithSort(
            label: 'table_header_label_containers'.tr(),
            sort: _sortColumn == 'CONTAINERS' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('CONTAINERS', value),
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

  void _sortList(List<PodSummary> displayList) {
    switch (_sortColumn) {
      case 'STATUS':
        _displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.status.compareTo(b.status);
          } else {
            return b.status.compareTo(a.status);
          }
        });
      case 'NAME':
        _displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.name.compareTo(b.name);
          } else {
            return b.name.compareTo(a.name);
          }
        });
      case 'CONTAINERS':
        _displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.containers.length.compareTo(b.containers.length);
          } else {
            return b.containers.length.compareTo(a.containers.length);
          }
        });
      case 'AGE':
        _displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.created.compareTo(b.created);
          } else {
            return b.created.compareTo(a.created);
          }
        });
    }
  }

  Future<List<PodSummary>> _requestList() async {
    final podman = await Podman.getInstance();
    if (podman == null) {
      return [];
    }
    //
    return await podman.pod.listPods();
  }

  void _refreshList() async {
    var displayList = await _requestList();
    // Filter
    if (_filter != '') {
      displayList = displayList.where((pod) {
        return pod.name.contains(_filter);
      }).toList();
    }
    // Sort
    if (_sortColumn != '') {
      _sortList(displayList);
    }
    // Checked
    final isCheckedPods = <String, bool>{};
    for (final pod in displayList) {
      isCheckedPods[pod.name] = _isCheckedPods[pod.name] ?? false;
    }
    //
    setState(() {
      _displayList = displayList;
      _isCheckedPods = isCheckedPods;
      _selectedCount =
          _isCheckedPods.values.where((val) => val).toList().length;
    });
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
  void didUpdateWidget(covariant PodList oldWidget) {
    super.didUpdateWidget(oldWidget);
    //
    if (!const DeepCollectionEquality()
        .equals(widget.containers, oldWidget.containers)) {
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
                      final pod = _displayList[index];
                      return PodListRow(
                        pod: pod,
                        checked: _isCheckedPods[pod.name] ?? false,
                        onSelected: (value) {
                          _toggleRowCheckbox(pod, value);
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
