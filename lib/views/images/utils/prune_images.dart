import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pocker/core/widgets/popup_dialog.dart';
import 'package:pocker/services/podman.dart';

void pruneImages(BuildContext context) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return PopupDialog.confirm(
        title: 'image_prune_label'.tr(),
        content: 'image_prune_confirm'.tr(),
        yesLabel: 'yes'.tr(),
        noLabel: 'cancel'.tr(),
      );
    },
  );
  if (result == true) {
    final podman = await Podman.getInstance();
    if (podman != null) {
      await podman.image.pruneImages();
    }
  }
}
