import 'package:flutter/material.dart';
import 'package:s4_firstapp/presentation/screens/counter_screnn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red
      ),
      home: CounterScreen()
    );
  }

}

