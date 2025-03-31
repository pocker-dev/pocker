import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/checkbox_state.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/widgets/popup_dialog.dart';
import 'package:pocker/core/widgets/table_header_with_sort.dart';
import 'package:pocker/services/image/model/image_summary.dart';
import 'package:pocker/services/podman.dart';
import 'package:pocker/services/system/model/image_usage.dart';

import 'image_list_row.dart';

class ImageList extends StatefulWidget {
  final List<ImageUsage> images;

  const ImageList({super.key, required this.images});

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  List<ImageUsage> _displayList = [];

  int _selectedCount = 0;
  Map<String, ImageSummary> _imageSummary = {};
  Map<String, CheckBoxState> _isCheckedImages = {};

  String _filter = '';
  String _sortColumn = '';
  SortStyle _sortStyle = SortStyle.none;

  bool _getHeaderCheckboxDisabled() {
    return _displayList.every((img) => _isCheckedImages[img.imageID]!.disabled);
  }

  bool? _getHeaderCheckboxState() {
    if (_displayList.isEmpty) {
      return false;
    }
    if (_displayList.every((img) =>
        _isCheckedImages[img.imageID]!.disabled ||
        _isCheckedImages[img.imageID]!.value)) {
      return true;
    }
    if (_displayList.every((img) => !_isCheckedImages[img.imageID]!.value)) {
      return false;
    }
    return null;
  }

  void _toggleAllCheckboxes(bool? value) {
    setState(() {
      for (final img in _displayList) {
        if (!_isCheckedImages[img.imageID]!.disabled) {
          _isCheckedImages[img.imageID]!.value = value ?? false;
        }
      }
      _selectedCount = _displayList
          .where((img) => _isCheckedImages[img.imageID]!.value)
          .toList()
          .length;
    });
  }

  void _toggleRowCheckbox(ImageUsage image, bool? value) {
    setState(() {
      _isCheckedImages[image.imageID]!.value = value ?? false;
      _selectedCount = _displayList
          .where((img) => _isCheckedImages[img.imageID]!.value)
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

  Future<void> _deleteCheckedImages() async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return PopupDialog.confirm(
          title: 'confirm_title'.tr(),
          content: 'image_delete_content'.plural(_selectedCount),
          yesLabel: 'yes'.tr(),
          noLabel: 'cancel'.tr(),
        );
      },
    );
    if (result == true) {
      final podman = await Podman.getInstance();
      if (podman != null) {
        _isCheckedImages.forEach((id, state) async {
          if (state.value) {
            await podman.image.removeImage(name: id);
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
                hintText: 'image_search_hint'.tr(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          _selectedCount > 0
              ? Tooltip(
                  message: 'item_delete_tooltip'.plural(_selectedCount),
                  waitDuration: Duration(seconds: 2),
                  child: FilledButton(
                    onPressed: () => _deleteCheckedImages(),
                    child: Icon(Symbols.delete, fill: 0),
                  ),
                )
              : SizedBox.shrink(),
          _selectedCount > 0
              ? Tooltip(
                  message: 'item_save_tooltip'.plural(_selectedCount),
                  waitDuration: Duration(seconds: 2),
                  child: FilledButton(
                    onPressed: () {
                      final images = _displayList
                          .where((img) => _isCheckedImages[img.imageID]!.value)
                          .toList();
                      Navigator.pushNamed(
                        context,
                        '/image/save',
                        arguments: images
                            .map((img) => RouteArgument(
                                  id: img.imageID,
                                  name: img.name,
                                ))
                            .toList(),
                      );
                    },
                    child: Icon(Symbols.save, fill: 0),
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
            label: 'table_header_label_arch'.tr(),
            sort: _sortColumn == 'ARCH' ? _sortStyle : SortStyle.none,
            onChanged: (value) => _toggleColumnSort('ARCH', value),
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

  void _sortList(List<ImageUsage> displayList) {
    switch (_sortColumn) {
      case 'STATUS':
        displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.containers.compareTo(b.containers);
          } else {
            return b.containers.compareTo(a.containers);
          }
        });
      case 'NAME':
        displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return a.displayName.compareTo(b.displayName);
          } else {
            return b.displayName.compareTo(a.displayName);
          }
        });
      case 'ARCH':
        displayList.sort((a, b) {
          final aa = _imageSummary[a.imageID];
          final bb = _imageSummary[b.imageID];
          if (aa == null || bb == null) {
            return 0;
          }
          if (_sortStyle == SortStyle.ascending) {
            return aa.arch.compareTo(bb.arch);
          } else {
            return bb.arch.compareTo(aa.arch);
          }
        });
      case 'AGE':
        displayList.sort((a, b) {
          if (_sortStyle == SortStyle.ascending) {
            return b.created.compareTo(a.created);
          } else {
            return a.created.compareTo(b.created);
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

  Future<Map<String, ImageSummary>> _requestSummary() async {
    final podman = await Podman.getInstance();
    if (podman == null) {
      return <String, ImageSummary>{};
    }
    //
    final Map<String, ImageSummary> imageSummary = {};
    final images = await podman.image.listImages();
    for (final img in images) {
      imageSummary[img.id] = img;
    }
    return imageSummary;
  }

  void _refreshList() async {
    final imageSummary = await _requestSummary();
    var displayList = widget.images
        .where((img) => imageSummary[img.imageID] != null)
        .toList();
    // Filter
    if (_filter != '') {
      displayList = displayList.where((img) {
        return img.name?.contains(_filter) ?? false;
      }).toList();
    }
    // Sort
    if (_sortColumn != '') {
      _sortList(displayList);
    }
    // Checked
    final isCheckedImages = <String, CheckBoxState>{};
    for (final img in displayList) {
      final checked = _isCheckedImages[img.imageID] ??
          CheckBoxState.init(disabled: img.containers > 0);
      if (img.containers > 0 && !checked.disabled) {
        isCheckedImages[img.imageID] = CheckBoxState.init(disabled: true);
      } else if (img.containers == 0 && checked.disabled) {
        isCheckedImages[img.imageID] = CheckBoxState.init(disabled: false);
      } else {
        isCheckedImages[img.imageID] = checked;
      }
    }
    //
    setState(() {
      _imageSummary = imageSummary;
      _displayList = displayList;
      _isCheckedImages = isCheckedImages;
      _selectedCount = _displayList
          .where((img) => _isCheckedImages[img.imageID]!.value)
          .toList()
          .length;
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
  void didUpdateWidget(covariant ImageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    //
    if (!const DeepCollectionEquality()
        .equals(widget.images, oldWidget.images)) {
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
                      final image = _displayList[index];
                      return ImageListRow(
                        image: image,
                        summary: _imageSummary[image.imageID],
                        checked:
                            _isCheckedImages[image.imageID]?.value ?? false,
                        onSelected: (value) {
                          _toggleRowCheckbox(image, value);
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
