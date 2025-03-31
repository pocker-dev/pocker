import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocker/providers/disk_usage_state.dart';
import 'package:pocker/routes/container_nav.dart';
import 'package:pocker/routes/image_nav.dart';
import 'package:pocker/routes/pod_nav.dart';
import 'package:pocker/routes/volume_nav.dart';
import 'package:provider/provider.dart';

import 'dashboard/dashboard_page.dart';
import 'settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    context.read<DiskUsageState>().startTimer();
    //
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1.0,
                    ),
                  ),
                ),
                child: NavigationRail(
                  extended: false,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Symbols.home, fill: 0, weight: 800),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Symbols.deployed_code, fill: 0, weight: 800),
                      label: Text('Containers'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Symbols.grid_view, fill: 0, weight: 800),
                      label: Text('Pods'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Symbols.stacks, fill: 0, weight: 800),
                      label: Text('Images'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Symbols.database, fill: 0, weight: 800),
                      label: Text('Volumes'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Symbols.settings, fill: 0, weight: 800),
                      label: Text('Settings'),
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    // Dashboard
                    DashboardPage(),
                    // Containers
                    buildContainersNavigator(),
                    // Pods
                    buildPodsNavigator(),
                    // Images
                    buildImagesNavigator(),
                    // Volumes
                    buildVolumesNavigator(),
                    // Settings
                    SettingsPage(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
