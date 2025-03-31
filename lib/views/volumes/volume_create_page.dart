import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/operate_page_layout.dart';
import 'package:pocker/core/widgets/text_edit_form_field.dart';
import 'package:pocker/services/podman.dart';

class VolumeCreatePage extends StatefulWidget {
  const VolumeCreatePage({super.key});

  @override
  State<VolumeCreatePage> createState() => _VolumeCreatePageState();
}

class _VolumeCreatePageState extends State<VolumeCreatePage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;

  /// Create status
  ///
  /// 0: pending
  /// 1: ready
  /// 2: creating
  /// 4: created
  int _status = 0;

  void _createVolume() async {
    final podman = await Podman.getInstance();
    if (podman != null) {
      await podman.volume.createVolume(name: _name!);
      setState(() {
        _status = 4;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatePageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'volumes_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'volume_create_title'.tr()),
      ],
      icon: Icon(Symbols.database, size: 30.0),
      title: 'volume_create_title'.tr(),
      showProgress: _status == 2,
      content: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_status == 0 || _status == 1)
            Form(
              key: _formKey,
              child: TextEditFormField(
                label: 'volume_to_create_label'.tr(),
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
            )
          else
            TextField(
              readOnly: true,
              controller: TextEditingController(text: _name),
            ),
          if (_status == 4)
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('done'.tr()),
            )
          else
            FilledButton.icon(
              onPressed: _status == 0
                  ? null
                  : () {
                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState?.save();
                        setState(() {
                          _status = 2;
                        });
                        _createVolume();
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
                  : Icon(Symbols.add_circle, fill: 1),
              label: Text('volume_create_label'.tr()),
            ),
        ],
      ),
    );
  }
}
