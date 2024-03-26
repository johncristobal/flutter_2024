import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s7_toktik/config/theme/app_theme.dart';
import 'package:s7_toktik/presentation/providers/discover_provider.dart';
import 'package:s7_toktik/presentation/screens/discover_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => DiscoverProvider()..loadNext())
      ],
      child: MaterialApp(
        title: 'TokTik',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        home: DiscoverScreen()
      ),
    );
  }
}