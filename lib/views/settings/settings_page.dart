import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'preferences_page.dart';
import 'registries_page.dart';
import 'widgets/menu_item.dart';
import 'widgets/menu_navigation.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _name = '';

  void onTap(String name, String title) {
    setState(() {
      _name = name;
    });
  }

  Widget _buildPage(BuildContext context) {
    switch (_name) {
      case 'preferences':
        return PreferencesPage();
      case 'registries':
        return RegistriesPage();
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 160.0,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          child: MenuNavigation(
            menuItems: [
              MenuItem('preferences', title: 'setting_preferences_label'.tr()),
              MenuItem('registries', title: 'setting_registries_label'.tr()),
            ],
            onTap: onTap,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: _buildPage(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
