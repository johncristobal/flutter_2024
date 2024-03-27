import 'package:flutter/material.dart';
import 'package:s9_widgetapp/config/theme/app_theme.dart';
import 'package:s9_widgetapp/presentation/screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selected: 0).getTheme(),
      title: 'Material App',
      home: HomeScreen()
    );
  }
}
