import 'package:flutter/material.dart';
import 'package:s12_cinemapedia/presentation/widgets/widgets.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;
  static const name = "home-screen";
  
  const HomeScreen({Key? key, required this.pageIndex}) : super(key: key);

  final viewRoutes = const <Widget> [
    HomeView(),
    SizedBox(),
    FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNav( current: pageIndex),
    );
  }
}

