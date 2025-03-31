import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pocker/core/widgets/popup_dialog.dart';
import 'package:pocker/services/podman.dart';

void deleteContainer(
  BuildContext context, {
  required String id,
  String? name,
  VoidCallback? onConfirm,
  VoidCallback? onSuccess,
}) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return PopupDialog.confirm(
        title: 'confirm_title'.tr(),
        content: 'container_delete_confirm'.tr(namedArgs: {
          'name': name ?? (id.length > 12 ? '\n$id' : id),
        }),
        yesLabel: 'yes'.tr(),
        noLabel: 'cancel'.tr(),
      );
    },
  );
  if (result == true) {
    if (onConfirm != null) {
      onConfirm();
    }
    final podman = await Podman.getInstance();
    if (podman != null) {
      await podman.container.deleteContainer(name: name ?? id);
      if (onSuccess != null) {
        onSuccess();
      }
    }
  }
}
