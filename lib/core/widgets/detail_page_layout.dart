import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'breadcrumb.dart';
import 'status_icon.dart';

class TabInfo {
  final String name;
  final Widget widget;

  const TabInfo({required this.name, required this.widget});
}

class DetailPageLayout extends StatelessWidget {
  final List<BreadcrumbInfo> breadcrumbs;

  final StatusIcon icon;
  final Widget title;
  final Widget? subtitle;
  final Widget? monitor;

  final List<Widget>? actions;

  final List<TabInfo> tabs;
  final int initialIndex;

  const DetailPageLayout({
    super.key,
    required this.breadcrumbs,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.tabs,
    this.actions,
    this.monitor,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(
          height: 50.0,
          child: Row(
            spacing: 8.0,
            children: [
              icon,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  subtitle ?? SizedBox.shrink(),
                ],
              ),
              Spacer(),
              if (actions != null) ...actions!,
            ],
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: tabs.length,
            initialIndex: initialIndex,
            child: Column(
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          dividerHeight: 0,
                          isScrollable: true,
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.secondary,
                          tabs: tabs.map((tab) => Tab(text: tab.name)).toList(),
                        ),
                      ),
                      monitor ?? SizedBox.shrink(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: TabBarView(
                      children: tabs.map((tab) => tab.widget).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
