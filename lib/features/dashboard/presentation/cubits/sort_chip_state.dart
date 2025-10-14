part of 'sort_chip_cubit.dart';

class SortChipState extends Equatable {
  final SortItem? selectedGeneral, selectedPlatform;
  final List<SortItem>? generalSortList;
  final List<SortItem>? platformSortList;

  const SortChipState({
    this.selectedGeneral,
    this.selectedPlatform,
    this.generalSortList,
    this.platformSortList,
  });

  SortChipState copyWith({
    SortItem? selectedGeneral, selectedPlatform,
    List<SortItem>? generalSortList,
    List<SortItem>? platformSortList,
  }) {
    return SortChipState(
      selectedGeneral: selectedGeneral ?? this.selectedGeneral,
      selectedPlatform: selectedPlatform,
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