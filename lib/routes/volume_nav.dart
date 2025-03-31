import 'package:flutter/material.dart';
import 'package:pocker/views/volumes/volume_create_page.dart';
import 'package:pocker/views/volumes/volume_detail_page.dart';
import 'package:pocker/views/volumes/volumes_page.dart';

Widget buildVolumesNavigator() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => VolumesPage();
          case '/volume/create':
            builder = (BuildContext context) => VolumeCreatePage();
          case '/volume/detail':
            final name = settings.arguments as String;
            builder = (BuildContext context) => VolumeDetailPage(name: name);
          default:
            throw Exception('Invalid volume route: ${settings.name}');
        }
        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    ),
  );
}
