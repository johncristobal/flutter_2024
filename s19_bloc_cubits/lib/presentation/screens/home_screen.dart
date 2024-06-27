import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text("Cubits"),
            subtitle: const Text("Estados simple"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: (){
              context.push("/cubits");
            },
          ),
          ListTile(
            title: const Text("Bloc"),
            subtitle: const Text("Estados simple"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: (){
              context.push("/bloc");
            },
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),

          ListTile(
            title: const Text("Register"),
            subtitle: const Text("Nuevo usuario form"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: (){
              context.push("/register");
            },
          ),
        ],
      ),
    );
  }
}