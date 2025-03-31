import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/core/widgets/breadcrumb.dart';
import 'package:pocker/core/widgets/operate_page_layout.dart';

class PodCreatePage extends StatefulWidget {
  const PodCreatePage({super.key});

  @override
  State<PodCreatePage> createState() => _PodCreatePageState();
}

class _PodCreatePageState extends State<PodCreatePage> {
  final _formKey = GlobalKey<FormState>();

  /// Creating status
  ///
  /// 0: pending
  /// 1: ready
  /// 2: creating
  /// 4: created
  int _status = 0;

  @override
  Widget build(BuildContext context) {
    return OperatePageLayout(
      breadcrumbs: [
        BreadcrumbInfo(name: 'pods_title'.tr(), link: ''),
        BreadcrumbInfo(name: 'pod_create_title'.tr()),
      ],
      icon: Icon(Symbols.database, size: 30.0),
      title: 'volume_create_title'.tr(),
      showProgress: _status == 2,
      content: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  }
}
