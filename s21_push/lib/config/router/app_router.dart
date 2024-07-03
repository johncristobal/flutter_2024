import 'package:go_router/go_router.dart';
import 'package:s21_push/presentation/screens/details_screen.dart';
import 'package:s21_push/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
     GoRoute(
      path: "/details/:messageId",
      builder: (context, state) => DetailsScreen(pushId: state.pathParameters["messageId"] ?? "",),
    )
  ] 
);