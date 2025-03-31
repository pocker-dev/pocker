import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pocker/core/widgets/popup_dialog.dart';
import 'package:pocker/services/podman.dart';

void pruneVolumes(BuildContext context) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return PopupDialog.confirm(
        title: 'volume_prune_label'.tr(),
        content: 'volume_prune_confirm'.tr(),
        yesLabel: 'yes'.tr(),
        noLabel: 'cancel'.tr(),
      );
    },
  );
  if (result == true) {
    final podman = await Podman.getInstance();
    if (podman != null) {
      await podman.volume.pruneVolumes();
    }
  }
}
