import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path/path.dart' as path;
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/operate_page_layout.dart';

class ImageImportPage extends StatefulWidget {
  const ImageImportPage({super.key});

  @override
  State<ImageImportPage> createState() => _ImageImportPageState();
}

class _ImageImportPageState extends State<ImageImportPage> {
  List<String> _paths = [];
  List<String> _names = [];

  /// Import status
  ///
  /// 0: pending
  /// 1: ready
  /// 2: importing
  int _status = 0;

  void _importImages() async {}

  Widget _buildTable(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        Row(
          children: [
            Expanded(
              child: SelectableText(
                'image_path_title'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: SelectableText(
                'image_name_title'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 50.0),
          ],
        ),
        for (int i = 0; i < _paths.length; i++)
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: _paths[i]),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: _names[i]),
                  onChanged: (val) {
                    _names[i] = val;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _paths.removeAt(i);
                    _names.removeAt(i);
                    if (_paths.isEmpty) {
                      _status = 0;
                    }
                  });
                },
                icon: Icon(
                  fill: 1,
                  size: 16.0,
                  Symbols.do_not_disturb_on,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OperatePageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'images_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'images_import_title'.tr()),
      ],
      icon: Icon(Symbols.download, size: 30.0),
      title: 'images_import_title'.tr(),
      showProgress: _status == 2,
      content: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectableText(
            'images_import_desc'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () async {
                  final file = await openFile();
                  if (file == null) {
                    return;
                  }
                  setState(() {
                    _status = 1;
                    _paths.add(file.path);
                    _names.add(path.basenameWithoutExtension(file.path));
                  });
                },
                label: Text('images_add_import_button_label'.tr()),
                icon: Icon(
                  Symbols.add_circle,
                  fill: 1,
                ),
              ),
              if (_paths.isNotEmpty) _buildTable(context),
            ],
          ),
          FilledButton.icon(
            onPressed: _status == 1 ? _importImages : null,
            icon: _status == 2
                ? SizedBox(
                    width: 15.0,
                    height: 15.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  )
                : Icon(Symbols.play_arrow, fill: 1),
            label: Text('images_import_title'.tr()),
          ),
        ],
      ),
    );
  }
}
