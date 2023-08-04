import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transactions_app/scaffold_with_bottom_bar.dart';
import 'feature/transactions/ui/diagram.dart';
import 'feature/transactions/ui/transactions_page.dart';
import 'feature/auth/ui/login.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return LoginPage();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
            child: ScaffoldWithNavBar(
              location: state.uri.toString(),
              child: child,
            )
        );
      },
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/transactions',
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: Scaffold(
                body: TransactionsPage(),
              ),
            );
          }
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/diagram',
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: DiagramPage(),
              ),
            );
          }
        ),
      ],
    )
  ],
);