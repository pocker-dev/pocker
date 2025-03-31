import 'package:flutter/material.dart';
import 'package:pocker/core/utils/route_argument.dart';
import 'package:pocker/views/images/image_build_page.dart';
import 'package:pocker/views/images/image_detail_page.dart';
import 'package:pocker/views/images/image_import_page.dart';
import 'package:pocker/views/images/image_load_page.dart';
import 'package:pocker/views/images/image_pull_page.dart';
import 'package:pocker/views/images/image_run_page.dart';
import 'package:pocker/views/images/image_save_page.dart';
import 'package:pocker/views/images/images_page.dart';

Widget buildImagesNavigator() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => ImagesPage();
          case '/image/load':
            builder = (BuildContext context) => ImageLoadPage();
          case '/image/import':
            builder = (BuildContext context) => ImageImportPage();
          case '/image/pull':
            builder = (BuildContext context) => ImagePullPage();
          case '/image/build':
            builder = (BuildContext context) => ImageBuildPage();
          case '/image/detail':
            final arg = settings.arguments as RouteArgument;
            builder = (BuildContext context) => ImageDetailPage(argument: arg);
          case '/image/run':
            final arg = settings.arguments as RouteArgument;
            builder = (BuildContext context) => ImageRunPage(argument: arg);
          case '/image/save':
            final arg = settings.arguments as List<RouteArgument>;
            builder = (BuildContext context) => ImageSavePage(argument: arg);
          default:
            throw Exception('Invalid image route: ${settings.name}');
        }
        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    ),
  );
}
