import 'package:flutter/material.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/views/containers/container_detail_page.dart';
import 'package:pocker/views/containers/containers_page.dart';

Widget buildContainersNavigator() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => ContainersPage();
          case '/container/detail':
            final arg = settings.arguments as RouteArgument;
            builder =
                (BuildContext context) => ContainerDetailPage(argument: arg);
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
