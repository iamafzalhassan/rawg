import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/constants/sort_option_constants.dart';
import 'package:rawg/core/enums/sort_chip_type.dart';
import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

part 'sort_chip_state.dart';

class SortChipCubit extends Cubit<SortChipState> {
  List<SortItem> generalSortList = SortOptionConstants.general;
  List<SortItem> platformSortList = SortOptionConstants.platforms;

  SortChipCubit() : super(const SortChipState()) {
    emit(
      state.copyWith(
        selectedGeneral: generalSortList.singleWhere((i) => i.isSelected!),
        generalSortList: generalSortList,
        platformSortList: platformSortList,
      ),
    );
  }

  void onItemSelected(SortChipType type, SortItem item) {
    if (type == SortChipType.general) {
      generalSortList = updateSelection(generalSortList, item.id!, false);
      emit(
        state.copyWith(
          selectedGeneral: generalSortList.singleWhere((i) => i.isSelected!),
          generalSortList: generalSortList,
        ),
      );
    } else {
      final isCurrentlySelected = platformSortList.any((i) => i.isSelected! && i.id == item.id);
      platformSortList = updateSelection(platformSortList, item.id!, isCurrentlySelected);
      emit(
        state.copyWith(
          selectedPlatform: isCurrentlySelected ? null : platformSortList.firstWhere((i) => i.isSelected!),
          platformSortList: platformSortList,
          clearPlatform: isCurrentlySelected,
        ),
      );
    }
  }

  List<SortItem> updateSelection(List<SortItem> list, int id, bool deSelect) {
    return list.map((i) {
      return SortItem(
        id: i.id,
        name: i.name,
        isSelected: deSelect ? false : i.id == id,
        value: i.value,
      );
    }).toList();
  }
}