import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  final String title;
  final Widget content;

  final Widget? icon;
  final VoidCallback? onSubmit;
  final String? yesLabel;
  final String? noLabel;

  const PopupDialog({
    super.key,
    required this.title,
    required this.content,
    this.icon,
    this.onSubmit,
    this.yesLabel,
    this.noLabel,
  });

  PopupDialog.confirm({
    super.key,
    required this.title,
    required String content,
    this.yesLabel,
    this.noLabel,
  })  : icon = null,
        onSubmit = null,
        content = SelectableText(content);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: SelectableText(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: content,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(noLabel ?? 'no'.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            if (onSubmit != null) {
              onSubmit!();
            }
            Navigator.of(context).pop(true);
          },
          child: Text(yesLabel ?? 'yes'.tr()),
        ),
      ],
    );
  }
}
