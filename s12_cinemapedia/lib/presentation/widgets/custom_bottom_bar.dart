import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  int getCurrentIndex(BuildContext context) {
    final loca = GoRouterState.of(context).name;
    switch (loca) {
      case "/": return 0;
      case "/categories": return 1;
      case "/favorites": return 2;
      default: return 0;
    }
  }

  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/");        
        break;
        case 1:
        context.go("/");        
        break;
        case 2:
        context.go("/favorites");        
        break;
      default:
    }
  }  

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      onTap: (value) => onItemTap(context, value),
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