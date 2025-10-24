import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_button.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:rawg/features/dashboard/presentation/widgets/game_overview_value_card.dart';
import 'package:rawg/features/dashboard/presentation/widgets/meta_score_box.dart';
import 'package:rawg/features/dashboard/presentation/widgets/store_chip.dart';

class GameOverview extends StatelessWidget {
  const GameOverview(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 2.5,
                      imageUrl: game.backgroundImage!,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  game.name!,
                                  style: AppFont.style(
                                    color: AppPalette.white,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'gameOverview.averagePlaytime'.tr(
                                    args: ['${game.playtime}'],
                                  ),
                                  style: AppFont.style(
                                    color: AppPalette.white,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Image.asset(AssetConstants.psIcon, width: 18.0),
                          SizedBox(width: 10.0),
                          Image.asset(AssetConstants.xboxIcon, width: 18.0),
                          SizedBox(width: 10.0),
                          Image.asset(AssetConstants.windowsIcon, width: 18.0),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GameOverviewValueCard(
                            'gameOverview.platforms'.tr(),
                            value: game.platforms,
                          ),
                          SizedBox(width: 20.0),
                          GameOverviewValueCard(
                            'gameOverview.metascores'.tr(),
                            child: MetaScoreBox(
                              state.selectedGame!.metacritic ?? 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GameOverviewValueCard(
                            'gameOverview.genre'.tr(),
                            value: game.getGenreNames,
                          ),
                          SizedBox(width: 20.0),
                          GameOverviewValueCard(
                            'gameOverview.releaseDate'.tr(),
                            value: intl.DateFormat(
                              "MMM d, yyyy",
                            ).format(game.released!),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GameOverviewValueCard(
                            'gameOverview.website'.tr(),
                            value: state.selectedGame!.website!.replaceFirst(
                              RegExp(r'https?://'),
                              '',
                            ),
                          ),
                          SizedBox(width: 20.0),
                          GameOverviewValueCard(
                            'gameOverview.publisher'.tr(),
                            value: state.selectedGame!.publisherNames,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GameOverviewValueCard(
                        'gameOverview.about'.tr(),
                        value: state.selectedGame!.shortDescription,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'gameOverview.availableStores'.tr(),
                            style: AppFont.style(
                              color: AppPalette.gray4,
                              fontSize: 10.0,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              StoreChip(
                                AssetConstants.steamIcon,
                                'stores.steam'.tr(),
                              ),
                              SizedBox(width: 5.0),
                              StoreChip(
                                AssetConstants.epicStoresIcon,
                                'stores.epicGames'.tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: RAWGButton.elevated(
                        icon: AssetConstants.giftIcon,
                        label: 'gameOverview.addToWishlist'.tr(),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.0,
            left: 8.0,
            child: MaterialButton(
              onPressed: () => context.pop(),
              color: AppPalette.black.withValues(alpha: 0.5),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10.0),
              minWidth: 40.0,
              height: 40.0,
              child: Image.asset(
                AssetConstants.leftArrowIcon,
                width: 20.0,
                height: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}