import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/enums/sort_chip_type.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_app_bar.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_button.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:rawg/features/dashboard/presentation/cubits/sort_chip_cubit.dart';
import 'package:rawg/features/dashboard/presentation/widgets/game_card.dart';
import 'package:rawg/features/dashboard/presentation/widgets/search_field.dart';
import 'package:rawg/features/dashboard/presentation/widgets/sort_chip.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RAWGAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SearchField(),
            ),
            Text(
              'New and trending',
              style: AppFont.style(color: AppPalette.white, fontSize: 30),
              textAlign: TextAlign.left,
            ),
            Text(
              'Based on player counts and release date.',
              style: AppFont.style(color: AppPalette.white, fontSize: 15),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 24.0),
            BlocBuilder<SortChipCubit, SortChipState>(
              builder: (context, state) => Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: SortChip(
                      SortChipType.general,
                      label: 'Order by ',
                      value: state.selectedGeneral!.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: SortChip(
                      SortChipType.platforms,
                      value: state.selectedPlatform?.name ?? 'Platforms',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  if (state.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state.message != null) {
                    return Center(
                      child: Text(
                        state.message!,
                        style: const TextStyle(fontSize: 16, color: AppPalette.white),
                      ),
                    );
                  }

                  return ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: state.games!.map((game) => GameCard(game)).toList(),
                      ),
                      if (!state.more && !state.end)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: RAWGButton(
                            'Load more',
                            () => onTapLoadMore(context),
                          ),
                        ),
                      if (state.more)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapLoadMore(BuildContext context) {
    context.read<DashboardCubit>().getGames(loadMore: true);
  }
}