import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:s9_widgetapp/config/menu/menu_items.dart';
import 'package:s9_widgetapp/presentation/widgets/drawner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const name = "home_screen";

  @override
  Widget build(BuildContext context) {
    final keyScaffold = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
        title: const Text("Home"),
       ),
       body: const _HomeView(),
       drawer: SideMenu(keyScaffold: keyScaffold)
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItem.length,
      itemBuilder: (context, index) {
        final item = appMenuItem[index];
        return _CustomTile(item: item);
      },
    );
  }
}

class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.item,
  });

  final MenuItem item;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(item.icon, color: colors.primary,),
      trailing: Icon(Icons.arrow_forward, color: colors.primary,),
      title: Text(item.title),
      subtitle: Text(item.subTitle),
      onTap: () {
        context.push( item.link );
        // context.pushNamed( CardsScreen.name );
      },
    );
  }
}
