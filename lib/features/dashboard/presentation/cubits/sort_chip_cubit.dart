import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/constants/sort_option_constants.dart';
import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

part 'sort_chip_state.dart';

class SortChipCubit extends Cubit<SortChipState> {
  Timer? timer;
  Duration duration = Duration(milliseconds: 500);

  SortChipCubit() : super(SortChipState(platformSortList: SortOptionConstants.platforms));

  void onItemSelected(SortItem item) {
    timer?.cancel();

    final isCurrentlySelected = state.platformSortList.any((i) => i.isSelected && i.id == item.id);

    final updatedList = updateSelection(
      state.platformSortList,
      item.id,
      isCurrentlySelected,
    );

    emit(
      SortChipState(
        selectedPlatform: isCurrentlySelected ? null : updatedList.firstWhere((i) => i.isSelected),
        platformSortList: updatedList,
        isFiltering: true,
      ),
    );

    timer = Timer(duration, () => emit(state.copyWith(isFiltering: false, shouldTriggerFilter: true)));
  }

  List<SortItem> updateSelection(List<SortItem> list, int id, bool deSelect) {
    return list.map((i) => SortItem(deSelect ? false : i.id == id, i.id, i.name, i.value)).toList();
  }

  void resetFilterTrigger() {
    emit(state.copyWith(shouldTriggerFilter: false));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}