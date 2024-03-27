import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({Key? key}) : super(key: key);
  static const name = "buttons_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buttons"),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){},
              child: Text("Elevated Button")
            ),

            ElevatedButton(
              onPressed: null, 
              child: Text("Elevated Button disabled")
            ),
      
            ElevatedButton.icon(
              onPressed: (){}, 
              icon: Icon(Icons.access_alarm_rounded),
              label: Text("Elevated icon"),
            ),

            FilledButton(onPressed: (){}, child: Text("Filled")),

            FilledButton.icon(
              onPressed: (){},
              icon: Icon(Icons.accessibility_new),
              label: Text("Filled icon"),
            ),

            OutlinedButton(
              onPressed: (){}, 
              child: Text("Outlined")
            ),

            OutlinedButton.icon(
              onPressed: (){},
              icon: Icon(Icons.terminal),
              label: Text("outlined icon"),
            ),

            TextButton(
              onPressed: (){},
              child: Text("Text button")
            ),

            TextButton.icon(
              onPressed: (){},
              icon: Icon(Icons.text_decrease),
              label: Text("text icon"),
            ),

            IconButton(onPressed: (){}, icon: Icon(Icons.add_reaction)),

            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.add_reaction),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red)
              ),
            )
      
          ],
        ),
      ),
    );
  }
}