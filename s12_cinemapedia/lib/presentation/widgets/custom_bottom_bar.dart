import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.label),
          label: "Categorias"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favs"
        )
      ],
    );
  }
}