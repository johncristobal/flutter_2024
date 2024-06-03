import 'package:go_router/go_router.dart';
import 'package:s12_cinemapedia/presentation/screens/screens.dart';

final appRputer = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: "movie/:id",
          name: MovieScreen.name,
          builder: (context, state) {
            final id = state.pathParameters["id"] ?? "no-id";
            return MovieScreen(movieId: id);
          } 
        )
      ]
    ),    
]);