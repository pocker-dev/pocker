import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pocker/core/widgets/popup_dialog.dart';
import 'package:pocker/core/widgets/text_edit_form_field.dart';
import 'package:pocker/services/podman.dart';

class ImageEditDialog extends StatefulWidget {
  final String? id;
  final String? name;

  const ImageEditDialog({
    super.key,
    this.id,
    this.name,
  }) : assert((id != null) || (name != null),
            'Either `id` or `name` must be specified');

  @override
  State<ImageEditDialog> createState() => _ImageEditDialogState();
}

class _ImageEditDialogState extends State<ImageEditDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  String? _repo;
  String? _tag;

  void _updateImageTag() async {
    final podman = await Podman.getInstance();
    if (podman == null) {
      return;
    }
    if (widget.name == null) {
      await podman.image.tagImage(name: widget.id!, repo: _repo!, tag: _tag!);
      return;
    }
    //
    if (widget.name! == '$_repo:$_tag') {
      return;
    }
    await podman.image.tagImage(name: widget.name!, repo: _repo!, tag: _tag!);
    await podman.image.removeImage(name: widget.name!);
  }

  @override
  void initState() {
    super.initState();
    //
    if (widget.name != null) {
      final repoTags = widget.name!.split(':');
      _repo = repoTags[0];
      _tag = repoTags[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupDialog(
      title: 'image_edit_title'.tr(),
      content: IntrinsicHeight(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10.0,
            children: [
              TextEditFormField(
                initialValue: _repo,
                label: 'image_name_label'.tr(),
                hint: 'image_name_hint'.tr(),
                submitting: _submitting,
                onSaved: (value) => _repo = value,
              ),
              TextEditFormField(
                initialValue: _tag,
                label: 'image_tag_label'.tr(),
                hint: 'image_tag_hint'.tr(),
                submitting: _submitting,
                onSaved: (value) => _tag = value,
              ),
            ],
          ),
        ),
      ),
      yesLabel: 'save'.tr(),
      onSubmit: () {
        if (_formKey.currentState?.validate() == true) {
          setState(() {
            _submitting = true;
          });
          _formKey.currentState?.save();
          _updateImageTag();
        }
      },
    );
  }
}
