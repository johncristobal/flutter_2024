import 'package:flutter/material.dart';
import 'dart:math' show Random;

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({Key? key}) : super(key: key);
  static const name = "animiated_screen";

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {

  double width = 50;
  double border = 8;
  double height = 50;
  Color color = Colors.indigo;

  void changeSize(BuildContext context) {
    final random = Random();
    width = random.nextInt(300).toDouble();
    border = random.nextInt(100).toDouble();
    height = random.nextInt(600).toDouble();

    color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated container"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => changeSize(context),
        child: const Icon(Icons.play_arrow),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.bounceOut,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(border)
          ),
        ),
      ),
    );
  }
}