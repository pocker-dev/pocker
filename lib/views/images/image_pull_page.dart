import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/shell.dart' as highlight_shell;
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/highlight.dart';
import 'package:pocker/core/widgets/operate_page_layout.dart';
import 'package:pocker/core/widgets/text_edit_form_field.dart';
import 'package:pocker/services/image/model/image_pull_progress.dart';
import 'package:pocker/services/podman.dart';

class ImagePullPage extends StatefulWidget {
  const ImagePullPage({super.key});

  @override
  State<ImagePullPage> createState() => _ImagePullPageState();
}

class _ImagePullPageState extends State<ImagePullPage> {
  final _formKey = GlobalKey<FormState>();
  final _progressList = <ImagePulledProgress>[];

  String? _name;

  /// Pulling status
  ///
  /// 0: pending
  /// 1: ready
  /// 2: pulling
  /// 4: pulled
  int _status = 0;

  void _pullImage() async {
    final repoTags = _name!.split(':');
    final podman = await Podman.getInstance();
    if (podman != null) {
      await podman.image.pullImage(
        name: repoTags[0],
        tag: repoTags.length > 1 ? repoTags[1] : 'latest',
        onData: (list) {
          setState(() {
            _progressList.addAll(list);
          });
        },
        onFinished: () {
          setState(() {
            _status = 4;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatePageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'images_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'image_pull_title'.tr()),
      ],
      icon: Icon(Symbols.cloud_download, size: 30.0),
      title: 'image_pull_subtitle'.tr(),
      showProgress: _status == 2,
      content: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectableText(
            'image_to_pull_label'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Form(
            key: _formKey,
            child: TextEditFormField(
              hint: 'image_name_hint'.tr(),
              submitting: _status == 2,
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
              onSaved: (value) => _name = value,
            ),
          ),
          //
          if (_status == 4)
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('done'.tr()),
            )
          else
            FilledButton.icon(
              onPressed: _status == 0 || _status == 2
                  ? null
                  : () {
                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState?.save();
                        setState(() {
                          _status = 2;
                        });
                        _pullImage();
                      }
                    },
              icon: _status == 2
                  ? SizedBox(
                      width: 15.0,
                      height: 15.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    )
                  : Icon(Symbols.cloud_download, fill: 1),
              label: Text('image_pull_title'.tr()),
            ),
          Highlight(
            language: highlight_shell.shell,
            text: _progressList
                .map((item) => item.error ?? item.stream ?? item.id)
                .toList()
                .join(''),
          ),
        ],
      ),
    );
  }
}
