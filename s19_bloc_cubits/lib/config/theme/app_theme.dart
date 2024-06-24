import 'package:flutter/material.dart';

class AppTheme { 
  ThemeData getData() {
    const seedColor = Colors.deepPurple;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      listTileTheme: const ListTileThemeData(
        iconColor: seedColor,
      )
    );
  }
}