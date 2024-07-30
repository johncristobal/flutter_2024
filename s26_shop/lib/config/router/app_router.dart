import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_notifier.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/presentation/screens/product_screen.dart';
import 'package:teslo_shop/features/products/products.dart';

final goRouterProvider = Provider((ref) {

  final routerProvider = ref.read( goRouterProviderNotifier );
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: routerProvider,
    routes: [

      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductScreen(
          productId: state.params["id"] ?? "noid",
        ),
      ),
    ],

    redirect: (context, state) {
      final isGoingto = state.subloc;
      final authStatus = routerProvider.authStatus;

      if(isGoingto == "/splash" && authStatus == AuthStatus.checking) return null;

      if(authStatus == AuthStatus.notauth) {
        if(isGoingto == "/login" || isGoingto == "/register") return null;
        return "/login";
      }

      if(authStatus == AuthStatus.auth) {
        
        if(isGoingto == "/login" || isGoingto == "/register" || isGoingto == "/splash") return "/";
      }
      return null;
    },
  );
});

// final appRouter = 