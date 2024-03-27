import 'package:go_router/go_router.dart';
import 'package:s9_widgetapp/presentation/screens/buttons_screen.dart';
import 'package:s9_widgetapp/presentation/screens/cards_screen.dart';

import '../../presentation/screens/home/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      name: ButtonScreen.name,
      path: '/buttons',
      builder: (context, state) => ButtonScreen(),
    ),
    GoRoute(
      name: CardsScreen.name,
      path: '/cards',
      builder: (context, state) => CardsScreen(),
    ),
  ],
);

