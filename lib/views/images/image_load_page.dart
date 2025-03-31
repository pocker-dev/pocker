import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/operate_page_layout.dart';
import 'package:pocker/services/podman.dart';

class ImageLoadPage extends StatefulWidget {
  const ImageLoadPage({super.key});

  @override
  State<ImageLoadPage> createState() => _ImageLoadPageState();
}

class _ImageLoadPageState extends State<ImageLoadPage> {
  final List<String> _paths = [];

  /// Load status
  ///
  /// 0: pending
  /// 1: ready
  /// 2: loading
  int _status = 0;

  void _loadImages() async {
    final podman = await Podman.getInstance();
    if (podman == null) {
      return;
    }
    for (final path in _paths) {
      await podman.image.importImage(path: path);
    }
  }

  Widget _buildTable(BuildContext context) {
    return Column(
      spacing: 8.0,
      children: [
        for (final (index, path) in _paths.indexed)
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: path),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _paths.removeAt(index);
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
        BreadcrumbInfo(name: 'images_load_title'.tr()),
      ],
      icon: Icon(Symbols.upload, size: 30.0),
      title: 'images_load_title'.tr(),
      showProgress: _status == 2,
      content: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                  });
                },
                label: Text('add_archive_title'.tr()),
                icon: Icon(
                  Symbols.add_circle,
                  fill: 1,
                ),
              ),
              if (_paths.isNotEmpty)
                Row(
                  children: [
                    Expanded(
                      child: SelectableText(
                        'image_archives_title'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              _buildTable(context),
            ],
          ),
          FilledButton.icon(
            onPressed: _status == 1
                ? () {
                    _loadImages();
                    Navigator.of(context).pop();
                  }
                : null,
            icon: _status == 2
                ? SizedBox(
                    width: 15.0,
                    height: 15.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  )
                : Icon(Symbols.play_arrow, fill: 1),
            label: Text('images_load_title'.tr()),
          ),
        ],
      ),
    );
  }
}
