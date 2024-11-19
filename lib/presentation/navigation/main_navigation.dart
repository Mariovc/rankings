import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ranking/presentation/widgets/pages/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainNavigation {
  GoRouter get router => _router;

  final _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}

class RouteNames {
  static const home = 'home';
}
