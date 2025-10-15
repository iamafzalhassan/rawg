part of 'sort_chip_cubit.dart';

class SortChipState extends Equatable {
  final SortItem? selectedGeneral, selectedPlatform;
  final List<SortItem>? generalSortList, platformSortList;

  const SortChipState({
    this.selectedGeneral,
    this.selectedPlatform,
    this.generalSortList,
    this.platformSortList,
  });

  SortChipState copyWith({
    SortItem? selectedGeneral,
    selectedPlatform,
    List<SortItem>? generalSortList,
    platformSortList,
    bool clearPlatform = false,
  }) {
    return SortChipState(
      selectedGeneral: selectedGeneral ?? this.selectedGeneral,
      selectedPlatform: clearPlatform ? null : (selectedPlatform ?? this.selectedPlatform),
      generalSortList: generalSortList ?? this.generalSortList,
      platformSortList: platformSortList ?? this.platformSortList,
    );
  }

  @override
  List<Object?> get props => [
    selectedGeneral,
    selectedPlatform,
    generalSortList,
    platformSortList,
  ];
}