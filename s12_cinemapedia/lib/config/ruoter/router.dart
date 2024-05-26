import 'package:go_router/go_router.dart';
import 'package:s12_cinemapedia/presentation/screens/movies/home_screen.dart';

final appRputer = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    )
]);