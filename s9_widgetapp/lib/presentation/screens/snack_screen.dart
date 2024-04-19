import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackScreen extends StatelessWidget {
  const SnackScreen({Key? key}) : super(key: key);
  static const name = "snack_screen";

  void showCustomsSnack(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Hola mundo"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
        duration: Duration(seconds: 2),
      )
    );
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Sure"),
          content: Text("Sit aliqua aliqua occaecat consequat velit duis. Culpa aliquip esse labore ea qui dolore amet magna excepteur labore anim. Reprehenderit magna proident nisi pariatur pariatur occaecat. Commodo nostrud ea eu eiusmod et laborum enim consequat Lorem commodo qui anim ut ipsum."),
          actions: [
            TextButton(
              onPressed: (){
                context.pop();
              }, 
              child: Text("Cancel")
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Snacks"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Show"),
        onPressed:() => showCustomsSnack(context),
        icon: const Icon(Icons.remove_red_eye),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: (){
                showAboutDialog(
                  context: context,
                  children: [
                    Text("Incididunt ad officia dolore est ea dolore consequat. Ipsum do pariatur proident commodo in irure cillum officia. Incididunt excepteur est enim culpa cillum eu. Magna adipisicing velit ad quis non exercitation cupidatat officia pariatur. Nisi labore laborum commodo laborum dolore dolore veniam id deserunt eu ullamco consequat. Laborum velit ex consequat nulla nostrud sint eu ipsum culpa culpa cillum elit sint cillum. Nostrud veniam sit est amet ipsum velit nisi.")
                  ]
                );
              }, 
              child: Text("Licencias")
            ),
            FilledButton(
              onPressed: (){
                openDialog(context);
              }, 
              child: Text("Dialog")
            )
          ],
        ),
      ),
    );
  }
}