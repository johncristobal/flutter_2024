import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s5_yesnoapp/config/theme/app_theme.dart';
import 'package:s5_yesnoapp/presentation/chat/chat_screen.dart';
import 'package:s5_yesnoapp/presentation/providers/chat_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
        title: 'Yes no app',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 3).theme(),
        home: const ChatScreen()
      ),
    );
  }
}