import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/constants/sort_option_constants.dart';
import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

part 'sort_chip_state.dart';

class SortChipCubit extends Cubit<SortChipState> {
  Timer? debounceTimer;
  static const Duration debounceDuration = Duration(milliseconds: 300);

  SortChipCubit() : super(SortChipState(platformSortList: SortOptionConstants.platforms));

  void onItemSelected(SortItem item) {
    debounceTimer?.cancel();

    final isCurrentlySelected = state.platformSortList.any((i) => i.isSelected && i.id == item.id);

    final updatedList = _updateSelection(
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

    debounceTimer = Timer(debounceDuration, () => emit(state.copyWith(isFiltering: false, shouldTriggerFilter: true)));
  }

  void resetFilterTrigger() {
    emit(state.copyWith(shouldTriggerFilter: false));
  }

  List<SortItem> _updateSelection(List<SortItem> list, int id, bool deSelect) {
    return list.map((i) => SortItem(deSelect ? false : i.id == id, i.id, i.name, i.value)).toList();
  }

  @override
  Future<void> close() {
    debounceTimer?.cancel();
    return super.close();
  }
}