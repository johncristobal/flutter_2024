import 'package:go_router/go_router.dart';
import 'package:s19_bloc_cubits/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/cubits",
      builder: (context, state) => const CubitCounterScreen(),
    ),
    GoRoute(
      path: "/bloc",
      builder: (context, state) => const BlocCounterScreen(),
    )
  ]
);