import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/config/ruoter/router.dart';
import 'package:s12_cinemapedia/config/theme/app_theme.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRputer,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Cinemapedia',
    );
  }
}
