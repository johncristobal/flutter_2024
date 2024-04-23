import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.green,
  Colors.red,
  Colors.purple
];

class AppTheme {

  final int selected;
  final bool isDark;

  AppTheme({
    required this.selected,
    required this.isDark,
  }) : assert (selected >= 0, "Selected must be greater than zero");

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDark ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[selected],
    appBarTheme: AppBarTheme(
      centerTitle: false
    )
  );

}