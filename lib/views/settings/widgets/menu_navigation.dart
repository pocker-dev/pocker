import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'menu_item.dart';

class MenuNavigation extends StatefulWidget {
  final List<MenuItem> menuItems;

  final MenuTapped onTap;

  const MenuNavigation({
    super.key,
    required this.menuItems,
    required this.onTap,
  });

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  String _tappedName = '';

  void onTap(String name, String title) {
    setState(() {
      _tappedName = name;
      widget.onTap(name, title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 8.0,
          top: 20.0,
          bottom: 30.0,
        ),
        child: SelectableText(
          'settings_title'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ...widget.menuItems.map((item) => item.build(
          onTap, _tappedName, Theme.of(context).colorScheme.primary)),
    ]);
  }
}
