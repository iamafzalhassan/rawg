import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/core/utils/show_snackbar.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_app_bar.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_button.dart';
import 'package:rawg/features/dashboard/domain/entities/game.dart';
import 'package:rawg/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:rawg/features/dashboard/presentation/cubits/sort_chip_cubit.dart';
import 'package:rawg/features/dashboard/presentation/widgets/game_card.dart';
import 'package:rawg/features/dashboard/presentation/widgets/search_field.dart';
import 'package:rawg/features/dashboard/presentation/widgets/sort_chip.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void applyPlatformFilter(String? platforms) {
    context.read<DashboardCubit>().getGames(platforms: platforms, clearPlatforms: platforms == null);
    context.read<SortChipCubit>().resetFilterTrigger();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<DashboardCubit>().loadInitial();

      final sortState = context.read<SortChipCubit>().state;

      if (sortState.triggerFilter) {
        applyPlatformFilter(sortState.selectedPlatform?.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
    listeners: [
      BlocListener<SortChipCubit, SortChipState>(listener: (context, state) => applyPlatformFilter(state.selectedPlatform?.value), listenWhen: (previous, current) => current.triggerFilter && !previous.triggerFilter),
      BlocListener<DashboardCubit, DashboardState>(
        listener: (context, state) {
          showSnackBar(state.errorMessage!, context);
        },
        listenWhen: (previous, current) => current.errorMessage != null && current.hasGames && previous.errorMessage != current.errorMessage,
      ),
    ],
    child: Scaffold(
      appBar: const RAWGAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: SearchField()),
            Text('dashboard.title'.tr(), style: AppFont.style(color: AppPalette.white, fontSize: 30.0)),
            Text('dashboard.subtitle'.tr(), style: AppFont.style(color: AppPalette.white, fontSize: 15.0)),
            const SizedBox(height: 24.0),
            BlocBuilder<SortChipCubit, SortChipState>(
              builder: (context, state) => SortChip(isLoading: state.filtering, value: state.selectedPlatform?.name ?? 'dashboard.platforms'.tr()),
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.showError) {
                    return Center(
                      child: Text(
                        state.errorMessage!,
                        style: AppFont.style(color: AppPalette.gray1, fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final games = state.games ?? const <Game>[];

                  return CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisExtent: 220.0, mainAxisSpacing: 10.0),
                        delegate: SliverChildBuilderDelegate((context, index) => GameCard(games[index]), childCount: games.length),
                      ),
                      if (state.showLoadMoreButton)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: RAWGButton.elevated(isLoading: state.more, label: 'dashboard.loadMore'.tr(), onPressed: () => context.read<DashboardCubit>().getGames(loadMore: true)),
                          ),
                        ),
                      if (state.more)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
