import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s9_widgetapp/presentation/providers/theme_provider.dart';

class ThemeScreen extends ConsumerWidget {
  static const name = "theme_screen";
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final dark = ref.watch( themeNotProvider ).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
        actions: [
          IconButton(onPressed: () {
            // ref.read( isDarkModeProvider.notifier ).state = !dark;
            ref.read( themeNotProvider.notifier ).toogleDark();
          }, icon: Icon(dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined))
        ],
      ),
      body: _ThemeView(),
    );
  }
}

class _ThemeView extends ConsumerWidget {
  const _ThemeView();

  @override
  Widget build(BuildContext context, ref) {

    final List<Color> colors = ref.watch( colorListProvider );
    final selected = ref.watch( themeNotProvider ).selected;

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        return RadioListTile(
          title: Text(" Este color ", style: TextStyle(color: color),),
          subtitle: Text("${color.value}"),
          activeColor: color,
          value: index, 
          groupValue: selected,
          onChanged: (value) {
            ref.read( themeNotProvider.notifier ).chnagecolor(value!);
          },
        );
      },
    );
  }
}