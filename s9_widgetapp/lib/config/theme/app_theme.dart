import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.green,
  Colors.red,
  Colors.purple
];

class AppTheme {

  final int selected;

  AppTheme({
    required this.selected
  }) : assert (selected >= 0, "Selected must be greater than zero");

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[selected],
    appBarTheme: AppBarTheme(
      centerTitle: false
    )
  );

}