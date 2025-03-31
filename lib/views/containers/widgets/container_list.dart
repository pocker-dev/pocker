import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/table_header_with_sort.dart';
import 'package:pocker/services/container/model/container_summary.dart';
import 'package:pocker/services/pod/model/pod_summary.dart';
import 'package:pocker/services/podman.dart';
import 'package:pocker/services/system/model/container_usage.dart';
import 'package:pocker/views/containers/model/container_group.dart';

import 'container_list_row.dart';

class ContainerList extends StatefulWidget {
  final List<ContainerUsage> containers;

  const ContainerList({
    super.key,
    required this.containers,
  });

  @override
  State<ContainerList> createState() => _ContainerListState();
}

class _ContainerListState extends State<ContainerList> {
  List<ContainerGroup> _displayList = [];

  int _selectedCount = 0;
  Map<String, bool> _isCheckedItems = {};

  String _filter = '';
  String _sortColumn = '';
  SortStyle _sortStyle = SortStyle.none;

  bool? _getHeaderCheckboxState() {
    if (_displayList.isEmpty) {
      return false;
    }
    if (_isCheckedItems.values.every((val) => val)) {
      return true;
    }
    if (_isCheckedItems.values.every((val) => !val)) {
      return false;
    }
    return null;
  }

  void _toggleAllCheckboxes(bool? value) {
    setState(() {
      _isCheckedItems.updateAll((key, val) => value ?? false);
      _selectedCount =
          _isCheckedItems.values.where((val) => val).toList().length;
    });
  }

  void _toggleRowCheckbox(ContainerGroup group, bool? value) {
    setState(() {
      _isCheckedItems[group.id] = value ?? false;
      _selectedCount =
          _isCheckedItems.values.where((val) => val).toList().length;
    });
  }

  void _toggleSubRowCheckbox(
    ContainerGroup group,
    ContainerSummary container,
    bool? value,
  ) {
    setState(() {
      _isCheckedItems[container.id] = value ?? false;
      _selectedCount =
          _isCheckedItems.values.where((val) => val).toList().length;
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
                hintText: 'container_search_hint'.tr(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          _selectedCount > 0
              ? Tooltip(
                  message: 'item_delete_tooltip'.plural(_selectedCount),
                  waitDuration: Duration(seconds: 2),
                  child: FilledButton(
                    onPressed: () {},
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
          flex: 2,
          child: TableHeaderWithSort(
            label: 'table_header_label_name'.tr(),
            sort: _sortColumn == 'NAME' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('NAME', value),
          ),
        ),
        Expanded(
          flex: 3,
          child: TableHeaderWithSort(
            label: 'table_header_label_image'.tr(),
            sort: _sortColumn == 'IMAGE' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('IMAGE', value),
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

  void _sortList(List<ContainerGroup> displayList) {
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
      case 'IMAGE':
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

  Future<List<ContainerGroup>> _composeList(
      List<ContainerSummary> containers) async {
    final podMap = await _requestContainerPod();
    final groupedMap = <String, ContainerGroup>{};
    for (final container in containers) {
      final pod = podMap[container.id];
      if (pod == null || container.pod == '') {
        groupedMap[container.id] = ContainerGroup.standalone(container);
        continue;
      }
      //
      final group = groupedMap[container.pod];
      if (group == null) {
        groupedMap[container.pod] = ContainerGroup.pod(pod, container);
      } else {
        group.add(container);
      }
    }
    return groupedMap.values.toList();
  }

  Future<Map<String, PodSummary>> _requestContainerPod() async {
    final podman = await Podman.getInstance();
    if (podman == null) {
      return {};
    }
    //
    final pods = await podman.pod.listPods();
    Map<String, PodSummary> containerPod = {};
    for (final pod in pods) {
      for (final container in pod.containers) {
        containerPod[container.id] = pod;
      }
    }
    return containerPod;
  }

  Future<List<ContainerSummary>> _requestSummary() async {
    final podman = await Podman.getInstance();
    if (podman == null) {
      return [];
    }
    //
    return await podman.container.listContainers();
  }

  void _refreshList() async {
    var containers = await _requestSummary();
    // Filter
    if (_filter != '') {
      containers = containers.where((container) {
        return container.names.where((val) => val.contains(_filter)).isNotEmpty;
      }).toList();
    }
    final displayList = await _composeList(containers);
    // Sort
    if (_sortColumn != '') {
      _sortList(displayList);
    }
    // Checked
    final isCheckedItems = <String, bool>{};
    for (final group in displayList) {
      isCheckedItems[group.id] = _isCheckedItems[group.id] ?? false;
    }
    //
    setState(() {
      _displayList = displayList;
      _isCheckedItems = isCheckedItems;
      _selectedCount =
          _isCheckedItems.values.where((val) => val).toList().length;
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
  void didUpdateWidget(covariant ContainerList oldWidget) {
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
                      final group = _displayList[index];
                      return ContainerListRow(
                        group: group,
                        checked: _isCheckedItems,
                        onSelected: (value) {
                          _toggleRowCheckbox(group, value);
                        },
                        onContainerSelected: (container, value) {
                          _toggleSubRowCheckbox(group, container, value);
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
