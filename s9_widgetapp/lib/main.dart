import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s9_widgetapp/config/router/router.dart';
import 'package:s9_widgetapp/config/theme/app_theme.dart';
import 'package:s9_widgetapp/presentation/providers/theme_provider.dart';

void main() => runApp(
  ProviderScope(child: MyApp())
);

class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    final dark = ref.watch( isDarkModeProvider );
    final selected = ref.watch( selectedColorProvider );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selected: selected, isDark: dark).getTheme(),
      title: 'Material App',
      routerConfig: appRouter,
    );
  }
}
