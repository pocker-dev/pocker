import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/disk_usage_state.dart';
import 'views/home_page.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //
    await DesktopWindow.setMinWindowSize(Size(1024, 680));
  }

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
      ],
      path: 'assets/translations',
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),
      saveLocale: true,
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      child: PockerApp(),
    ),
  );
}

class PockerApp extends StatelessWidget {
  const PockerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiskUsageState()),
      ],
      child: MaterialApp(
        title: 'Pocker',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.deepPurple,
          ),
        ),
        home: HomePage(),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
      ),
    );
  }
}
