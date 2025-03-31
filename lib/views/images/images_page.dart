import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/engine_not_found.dart';
import 'package:pocker/providers/disk_usage_state.dart';
import 'package:pocker/services/system/model/image_usage.dart';
import 'package:provider/provider.dart';

import 'utils/prune_images.dart';
import 'widgets/image_list.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  Widget _buildTitleActions() {
    return Row(
      spacing: 5.0,
      children: [
        SelectableText(
          'images_title'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Tooltip(
          message: 'image_prune_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => pruneImages(context),
            icon: Icon(Symbols.delete),
            label: Text('image_prune_label'.tr()),
          ),
        ),
        Tooltip(
          message: 'image_load_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/image/load'),
            icon: Icon(Symbols.upload),
            label: Text('image_load_label'.tr()),
          ),
        ),
        // Tooltip(
        //   message: 'image_import_tooltip'.tr(),
        //   waitDuration: Duration(seconds: 2),
        //   child: FilledButton.icon(
        //     onPressed: () => Navigator.pushNamed(context, '/image/import'),
        //     icon: Icon(Symbols.download),
        //     label: Text('image_import_label'.tr()),
        //   ),
        // ),
        Tooltip(
          message: 'image_pull_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/image/pull'),
            icon: Icon(Symbols.cloud_download),
            label: Text('image_pull_label'.tr()),
          ),
        ),
        Tooltip(
          message: 'image_build_tooltip'.tr(),
          waitDuration: Duration(seconds: 2),
          child: FilledButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/image/build'),
            icon: Icon(Symbols.deployed_code_update),
            label: Text('image_build_label'.tr()),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ImageUsage>? images = context.watch<DiskUsageState>().images;
    if (images == null) {
      return EngineNotFound(title: 'images_title'.tr());
    }
    return Column(
      children: [
        _buildTitleActions(),
        ImageList(
          images: images,
        ),
      ],
    );
  }
}
