
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:s9_widgetapp/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> keyScaffold;

  const SideMenu({required this.keyScaffold});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navIndex = 0;

  @override
  Widget build(BuildContext context) {

    final hasnotch = MediaQuery.of(context).viewPadding.top > 35;
    
    return NavigationDrawer(
      selectedIndex: navIndex,
      onDestinationSelected: (value) {
        setState(() {
          navIndex = value;
        });

        final item = appMenuItem[value];
        context.push( item.link );
        widget.keyScaffold.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasnotch ? 10 : 20, 16, 10),
          child: const Text("Main"),
        ),

        ...appMenuItem
        .sublist(0,3)
        .map((e) => NavigationDrawerDestination(
          icon: Icon(e.icon), 
          label: Text(e.title)
        )),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider()
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10 , 16, 10),
          child: Text("Others"),
        ),

        ...appMenuItem
        .sublist(3)
        .map((e) => NavigationDrawerDestination(
          icon: Icon(e.icon), 
          label: Text(e.title)
        )),
      ]
    );
  }
}