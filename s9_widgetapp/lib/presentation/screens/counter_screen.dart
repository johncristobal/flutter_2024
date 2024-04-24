import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s9_widgetapp/presentation/providers/counter_provider.dart';
import 'package:s9_widgetapp/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final value = ref.watch( counterProvider );
    final dark = ref.watch( themeNotProvider ).isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpood"),
        actions: [
          IconButton(
            onPressed: () {
            ref.read( themeNotProvider.notifier ).toogleDark();
          }, icon: Icon(dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined))
        ],
      ),
      body: Center(
        child: Text("Valor $value", style: Theme.of(context).textTheme.titleLarge,),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ad_units),
        onPressed: () {
          // ref.read( counterProvider.notifier ).state++;
          ref.read( counterProvider.notifier).update((state) => state + 1);

        },
      ),
    );
  }
}