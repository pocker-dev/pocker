import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BreadcrumbInfo {
  BreadcrumbInfo({required this.name, this.link});

  final String name;
  final String? link;
}

class Breadcrumb extends StatelessWidget {
  final List<BreadcrumbInfo> breadcrumbs;

  const Breadcrumb({super.key, required this.breadcrumbs});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (final (index, breadcrumb) in breadcrumbs.indexed) {
      if (index > 0) widgets.add(Icon(Symbols.chevron_right));
      widgets.add(breadcrumb.link != null
          ? TextButton(
              onPressed: () {
                if (breadcrumb.link == '') {
                  Navigator.pop(context);
                } else {
                  Navigator.pushNamed(context, breadcrumb.link!);
                }
              },
              child: Text(breadcrumb.name),
            )
          : SelectableText(breadcrumb.name));
    }
    //
    return Row(
      children: widgets,
    );
  }
}
