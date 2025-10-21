import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/core/utils/show_loading.dart';
import 'package:rawg/core/utils/show_snackbar.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';

class GameCard extends StatelessWidget {
  const GameCard(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 32) / 2 - 5;

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: AppPalette.black1,
          ),
          height: 220.0,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 135,
                  imageUrl: game.backgroundImage!,
                  width: width,
                  memCacheWidth: (width * 2).toInt(),
                  errorWidget: (context, url, error) => Container(
                    color: AppPalette.gray5,
                    child: Image.asset(AssetConstants.imageBrokenIcon),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  game.name!,
                  style: AppFont.style(color: AppPalette.white, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  DateFormat("MMM d, yyyy").format(game.released!),
                  style: AppFont.style(color: AppPalette.gray1, fontSize: 11),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        color: AppPalette.gray6,
                      ),
                      height: 25.0,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AssetConstants.plusIcon, width: 12.0),
                          const SizedBox(width: 5.0),
                          Text(
                            NumberFormat.decimalPattern().format(
                              game.ratingsCount,
                            ),
                            style: AppFont.style(
                              color: AppPalette.gray1,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Image.asset(AssetConstants.psIcon, width: 13.0),
                    const SizedBox(width: 5.0),
                    Image.asset(AssetConstants.xboxIcon, width: 13.0),
                    const SizedBox(width: 5.0),
                    Image.asset(AssetConstants.windowsIcon, width: 13.0),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTap(BuildContext context) async {
    ShowLoading.show(context);
    await context.read<DashboardCubit>().getGameOverview(game.id!);
    if (context.mounted) {
      ShowLoading.hide(context);
      final state = context.read<DashboardCubit>().state;
      if (state.errorMessage != null && state.selectedGame == null) {
        showSnackBar(context, state.errorMessage!);
      } else if (state.selectedGame != null) {
        context.pushNamed(RouteConstants.gameOverview, extra: game);
      }
    }
  }
}