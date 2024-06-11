import 'package:go_router/go_router.dart';
import 'package:s12_cinemapedia/presentation/screens/home/favorites_view.dart';
import 'package:s12_cinemapedia/presentation/screens/home/home_view.dart';
import 'package:s12_cinemapedia/presentation/screens/screens.dart';

final appRputer = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => const HomeView(),
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
        GoRoute(
          path: "/favorites",
          builder: (context, state) => const FavoriteView(),
        ),
      ]
    )

    // Rutas padre-hijo
    // GoRoute(
    //   path: "/",
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: FavoriteView(),),
      // routes: [
      //   GoRoute(
      //     path: "movie/:id",
      //     name: MovieScreen.name,
      //     builder: (context, state) {
      //       final id = state.pathParameters["id"] ?? "no-id";
      //       return MovieScreen(movieId: id);
      //     } 
      //   )
    //   ]
    // ),    
]);