import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/file_save_form_field.dart';
import 'package:pocker/core/widgets/operate_page_layout.dart';
import 'package:pocker/services/podman.dart';

class ImageSavePage extends StatefulWidget {
  final List<RouteArgument> argument;

  const ImageSavePage({
    super.key,
    required this.argument,
  });

  @override
  State<ImageSavePage> createState() => _ImageSavePageState();
}

class _ImageSavePageState extends State<ImageSavePage> {
  final _formKey = GlobalKey<FormState>();

  List<RouteArgument> _images = [];

  String? _path;

  /// Saving status
  ///
  /// 0: pending
  /// 1: ready
  /// 2: saving
  int _status = 0;

  void _saveImage() async {
    final podman = await Podman.getInstance();
    if (podman != null) {
      await podman.image.exportImages(
        names: _images.map((val) => val.identity).toList(),
        path: _path!,
      );
    }
  }

  Widget _buildTable(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'images_save_label'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        for (final arg in _images)
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(text: arg.shortId),
                ),
              ),
              IconButton(
                onPressed: widget.argument.length > 1
                    ? () {
                        setState(() {
                          _images.removeWhere((val) => val.name != null
                              ? val.name == arg.name
                              : val.id == arg.id);
                        });
                      }
                    : null,
                icon: Icon(
                  fill: 1,
                  size: 16.0,
                  Symbols.do_not_disturb_on,
                  color: widget.argument.length > 1
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
              ),
            ],
          )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _images = widget.argument;
  }

  @override
  Widget build(BuildContext context) {
    final firstName = _images[0].imageRepositoryTag[0];
    return OperatePageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'images_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'images_save_title'.tr()),
      ],
      icon: Icon(Symbols.save, size: 30.0),
      title: widget.argument.length == 1
          ? 'images_save_title_arg'.tr(args: [firstName])
          : 'images_save_title'.tr(),
      showProgress: _status == 2,
      content: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: FileSaveFormField(
              label: 'images_export_label'.tr(),
              submitting: _status == 2,
              suggestedName: widget.argument.length == 1
                  ? '${firstName.split('/').last}.tar'
                  : 'images.tar',
              onChanged: (value) {
                if (value.isNotEmpty && _status == 0) {
                  setState(() {
                    _status = 1;
                  });
                } else if (value.isEmpty && _status == 1) {
                  setState(() {
                    _status = 0;
                  });
                }
              },
              onSaved: (value) => _path = value,
            ),
          ),
          if (widget.argument.length != 1) _buildTable(context),
          FilledButton.icon(
            onPressed: _status == 1
                ? () {
                    if (_formKey.currentState?.validate() == true) {
                      _formKey.currentState?.save();
                      setState(() {
                        _status = 2;
                      });
                      _saveImage();
                      Navigator.of(context).pop();
                    }
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
            label: Text('images_save_title'.tr()),
          ),
        ],
      ),
    );
  }
}
