import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/constants/sort_option_constants.dart';
import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

part 'sort_chip_state.dart';

class SortChipCubit extends Cubit<SortChipState> {
  Duration duration = Duration(seconds: 1);
  Timer? timer;

  SortChipCubit()
    : super(SortChipState(platformSortList: SortOptionConstants.platforms));

  void onItemSelected(SortItem item) {
    timer?.cancel();

    final isCurrentlySelected = state.platformSortList.any(
      (i) => i.isSelected! && i.id == item.id,
    );

    final updatedList = updateSelection(
      isCurrentlySelected,
      item.id!,
      state.platformSortList,
    );

    emit(
      SortChipState(
        filtering: true,
        selectedPlatform: isCurrentlySelected
            ? null
            : updatedList.firstWhere((i) => i.isSelected!),
        platformSortList: updatedList,
      ),
    );

    timer = Timer(
      duration,
      () => emit(state.copyWith(filtering: false, triggerFilter: true)),
    );
  }

  List<SortItem> updateSelection(bool deSelect, int id, List<SortItem> list) {
    return list.map(
          (i) => SortItem(
            isSelected: deSelect ? false : i.id == id,
            id: i.id,
            name: i.name,
            value: i.value,
          ),
        ).toList();
  }

  void resetFilterTrigger() {
    emit(state.copyWith(triggerFilter: false));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}