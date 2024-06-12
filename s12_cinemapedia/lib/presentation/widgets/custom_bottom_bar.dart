import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNav extends StatelessWidget {
  final int current;
  const CustomBottomNav({Key? key, required this.current}) : super(key: key);

  void onItemTapped( BuildContext context, int index ) {
    switch (index) {
      case 0:
        context.go("/home/0");
        break;
        case 1:
        context.go("/home/1");
        break;
        case 2:
        context.go("/home/2");
        break;
        
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: current,
      onTap: (value) =>  onItemTapped(context, value),
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