import 'package:go_router/go_router.dart';
import 'package:s12_cinemapedia/presentation/screens/screens.dart';

final appRputer = GoRouter(
  initialLocation: "/home/0",
  routes: [
    GoRoute(
      path: "/home/:page",
      name: HomeScreen.name,
      builder: (context, state) {
        final index = state.pathParameters["page"] ?? "0";
        return HomeScreen(pageIndex: int.parse(index),);
      },
      routes: [
        GoRoute(
          path: "movie/:id",
          name: MovieScreen.name,
          builder: (context, state) {
            final id = state.pathParameters["id"] ?? "no-id";
            return MovieScreen(movieId: id);
          } 
        ),
      ]
    ),    
    GoRoute(
      path: "/", 
      redirect: (_, __) => "/home/0",
    )
]);