import 'package:flutter/material.dart';
import 'package:s9_widgetapp/config/router/router.dart';
import 'package:s9_widgetapp/config/theme/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selected: 0).getTheme(),
      title: 'Material App',
      routerConfig: appRouter,
    );
  }
}
