import 'package:flutter/material.dart';
import 'package:s5_yesnoapp/config/theme/app_theme.dart';
import 'package:s5_yesnoapp/presentation/chat/chat_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yes no app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 3).theme(),
      home: const ChatScreen()
    );
  }
}