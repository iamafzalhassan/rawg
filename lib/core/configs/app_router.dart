import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/presentation/pages/dashboard.dart';
import 'package:rawg/features/dashboard/presentation/pages/game_overview.dart';
import 'package:rawg/features/settings/presentation/pages/settings.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/dashboard',
        name: RouteConstants.dashboard,
        builder: (context, state) => Dashboard(),
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
        builder: (context, state) => Settings(),
      ),
    ],
  );
}