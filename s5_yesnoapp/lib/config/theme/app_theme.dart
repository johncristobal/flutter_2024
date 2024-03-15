import 'package:flutter/material.dart';

const Color CustomColor = Color(0xff49149f);
const List<Color> colorThemes = [
  CustomColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink
];

class AppTheme {

  final int selectedColor;

  AppTheme({
    this.selectedColor = 0
  }) : assert(selectedColor < colorThemes.length - 1);

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorThemes[selectedColor]
    );

  }
}