import 'package:flutter/material.dart';
import 'package:s19_bloc_cubits/config/router/app_router.dart';
import 'package:s19_bloc_cubits/config/theme/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Material App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getData(),
    );
  }
}