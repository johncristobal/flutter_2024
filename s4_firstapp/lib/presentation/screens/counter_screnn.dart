import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {

  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter screen"),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                clickCounter = 0;
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$clickCounter", style: const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),),
            Text((clickCounter == 1) ? "Click" : "Clicks", style: const TextStyle(fontSize: 25))
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(icon: Icons.plus_one, onPressed: () { 
            setState(() => clickCounter++ );
           },),

          const SizedBox(height: 8,),
          CustomButton(icon: Icons.exposure_minus_1_outlined, onPressed: () { 
              setState(() => clickCounter-- );
           },),

          const SizedBox(height: 8,),
          CustomButton(icon: Icons.refresh_outlined, onPressed: () { 
              setState(() => clickCounter = 0 );
           },),
        ],
      )
    );
  }
}

class CustomButton extends StatelessWidget {

  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.icon, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}