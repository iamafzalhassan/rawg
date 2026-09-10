import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/features/auth/presentation/pages/auth.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/presentation/pages/dashboard.dart';
import 'package:rawg/features/dashboard/presentation/pages/game_overview.dart';
import 'package:rawg/features/settings/presentation/pages/settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/auth',
    redirect: (context, state) {
      final isAuthenticated = Supabase.instance.client.auth.currentUser != null;
      final isAuthRoute = state.matchedLocation == '/auth';

      if (isAuthenticated && isAuthRoute) {
        return '/dashboard';
      }

      if (!isAuthenticated && !isAuthRoute) {
        return '/auth';
      }

      return null;
    },
    routes: [
      GoRoute(builder: (context, state) => const Auth(), name: RouteConstants.auth, path: '/auth'),
      GoRoute(
        builder: (context, state) => const Dashboard(),
        name: RouteConstants.dashboard,
        path: '/dashboard',
        routes: [
          GoRoute(
            builder: (context, state) {
              final game = state.extra as Game;
              return GameOverview(game);
            },
            name: RouteConstants.gameOverview,
            path: 'game-overview',
          ),
        ],
      ),
      GoRoute(builder: (context, state) => const Settings(), name: RouteConstants.settings, path: '/settings'),
    ],
  );

  AppRouter._();
}
