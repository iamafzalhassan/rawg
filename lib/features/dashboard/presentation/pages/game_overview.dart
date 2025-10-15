import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state.loading) {
              return SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 2.5,
                      imageUrl: game.backgroundImage,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 8.0,
                        left: 8.0,
                      ),
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppPalette.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          height: 35,
                          padding: EdgeInsets.all(8.0),
                          width: 35,
                          child: Image.asset(AssetConstants.leftArrowIcon),
                        ),
                      ),
                    ),
                  ],
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
                              game.name,
                              style: AppFont.style(
                                color: AppPalette.white,
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Average playtime almost ${game.playtime} Hours.',
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
                        label: 'Platforms',
                        value: 'PC, PlayStation 5, Xbox Series S/X, PlayStation 4, PlayStation 3, Xbox 360, Xbox One',
                      ),
                      SizedBox(width: 20.0),
                      GameOverviewValueCard(
                        label: 'Metascores',
                        child: MetaScoreBox(state.selectedGame!.metacritic),
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
                      GameOverviewValueCard(label: 'Genre', value: 'Action'),
                      SizedBox(width: 20.0),
                      GameOverviewValueCard(
                        label: 'Release Date',
                        value: DateFormat("MMM d, yyyy").format(game.released),
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
                        label: 'Website',
                        value: state.selectedGame!.website.replaceFirst(RegExp(r'https?://'), ''),
                      ),
                      SizedBox(width: 20.0),
                      GameOverviewValueCard(
                        label: 'Publisher',
                        value: 'Rockstar games',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GameOverviewValueCard(
                    label: 'About',
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
                        'Available Stores',
                        style: AppFont.style(
                          color: AppPalette.gray4,
                          fontSize: 10.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          StoreChip(AssetConstants.steamIcon, 'Steam'),
                          SizedBox(width: 5.0),
                          StoreChip(
                            AssetConstants.epicStoresIcon,
                            'Epic Games',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RAWGButton(
                    icon: AssetConstants.plusIcon,
                    'Add to collection',
                    () {},
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RAWGButton(
                    icon: AssetConstants.giftIcon,
                    'Add to wishlist',
                    () {},
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            );
          },
        ),
      ),
    );
  }
}
