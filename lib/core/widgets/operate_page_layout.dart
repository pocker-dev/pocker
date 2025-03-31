import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'breadcrumb.dart';

class OperatePageLayout extends StatelessWidget {
  final List<BreadcrumbInfo> breadcrumbs;

  final Icon icon;
  final String title;
  final Widget content;

  final bool? showProgress;
  final List<Widget>? actions;

  const OperatePageLayout({
    super.key,
    required this.breadcrumbs,
    required this.icon,
    required this.title,
    required this.content,
    this.showProgress,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            spacing: 8.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Breadcrumb(breadcrumbs: breadcrumbs),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Symbols.close, fill: 1),
                  ),
                ],
              ),
              Row(
                spacing: 8.0,
                children: [
                  icon,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (actions != null) ...actions!,
                ],
              ),
              SizedBox(height: 0.0),
            ],
          ),
        ),
        if (showProgress != null && showProgress!)
          LinearProgressIndicator(minHeight: 1.0),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: screenHeight - 160.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: content,
          ),
        ),
      ],
    );
  }
}
