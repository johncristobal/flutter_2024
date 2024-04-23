import 'package:go_router/go_router.dart';
import 'package:s9_widgetapp/presentation/screens/animated_screen.dart';
import 'package:s9_widgetapp/presentation/screens/buttons_screen.dart';
import 'package:s9_widgetapp/presentation/screens/cards_screen.dart';
import 'package:s9_widgetapp/presentation/screens/counter_screen.dart';
import 'package:s9_widgetapp/presentation/screens/infinite_screen.dart';
import 'package:s9_widgetapp/presentation/screens/progress_screen.dart';
import 'package:s9_widgetapp/presentation/screens/snack_screen.dart';
import 'package:s9_widgetapp/presentation/screens/theme_screen.dart';
import 'package:s9_widgetapp/presentation/screens/tutoria_screen.dart';
import 'package:s9_widgetapp/presentation/screens/ui_screen.dart';

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
    GoRoute(
      name: ProgressScreen.name,
      path: '/progress',
      builder: (context, state) => ProgressScreen(),
    ),
    GoRoute(
      name: SnackScreen.name,
      path: '/snack',
      builder: (context, state) => SnackScreen(),
    ),
    GoRoute(
      name: AnimatedScreen.name,
      path: '/animated',
      builder: (context, state) => AnimatedScreen(),
    ),
    GoRoute(
      name: UIControlsScreen.name,
      path: '/uicontrols',
      builder: (context, state) => UIControlsScreen(),
    ),
    GoRoute(
      name: TutorialScreen.name,
      path: '/tutorial',
      builder: (context, state) => TutorialScreen(),
    ),
    GoRoute(
      name: InfiniteScreen.name,
      path: '/infinite',
      builder: (context, state) => InfiniteScreen(),
    ),
    GoRoute(
      name: "riverppod",
      path: '/diverpod',
      builder: (context, state) => CounterScreen(),
    ),
    GoRoute(
      name: ThemeScreen.name,
      path: '/theme',
      builder: (context, state) => ThemeScreen(),
    ),
  ],
);

