import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/features/auth/presentation/pages/auth.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/presentation/pages/dashboard.dart';
import 'package:rawg/features/dashboard/presentation/pages/game_overview.dart';
import 'package:rawg/features/settings/presentation/pages/settings.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/auth',
        name: RouteConstants.auth,
        builder: (context, state) => const Auth(),
      ),
      GoRoute(
        path: '/dashboard',
        name: RouteConstants.dashboard,
        builder: (context, state) => const Dashboard(),
        routes: [
          GoRoute(
            path: 'game-overview',
            name: RouteConstants.gameOverview,
            builder: (context, state) {
              final game = state.extra as Game;
              return GameOverview(game);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        name: RouteConstants.settings,
        builder: (context, state) => const Settings(),
      ),
    ],
  );
}