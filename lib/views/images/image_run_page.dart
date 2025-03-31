import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/operate_page_layout.dart';

class ImageRunPage extends StatefulWidget {
  final RouteArgument argument;

  const ImageRunPage({
    super.key,
    required this.argument,
  });

  @override
  State<ImageRunPage> createState() => _ImageRunPageState();
}

class _ImageRunPageState extends State<ImageRunPage> {
  /// Run status
  ///
  /// 0: pending
  /// 1: ready
  /// 2: running
  int _status = 0;

  @override
  Widget build(BuildContext context) {
    return OperatePageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'images_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'image_run_title'.tr()),
      ],
      icon: Icon(Symbols.play_arrow, fill: 1, size: 30.0),
      title: 'image_run_subtitle'.tr(args: [
        widget.argument.identity,
      ]),
      showProgress: _status == 2,
      content: Center(
        child: Text('Run page'),
      ),
    );
  }
}
