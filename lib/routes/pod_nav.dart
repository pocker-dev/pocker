import 'package:flutter/material.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/views/pods/pod_create_page.dart';
import 'package:pocker/views/pods/pod_detail_page.dart';
import 'package:pocker/views/pods/pods_page.dart';

Widget buildPodsNavigator() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => PodsPage();
          case '/pod/detail':
            final arg = settings.arguments as RouteArgument;
            builder = (BuildContext context) => PodDetailPage(argument: arg);
          case '/pod/create':
            builder = (BuildContext context) => PodCreatePage();
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
