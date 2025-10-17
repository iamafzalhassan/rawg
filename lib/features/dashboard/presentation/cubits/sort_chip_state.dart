part of 'sort_chip_cubit.dart';

class SortChipState extends Equatable {
  final SortItem? selectedPlatform;
  final List<SortItem>? platformSortList;

  const SortChipState({
    this.selectedPlatform,
    this.platformSortList,
  });

  SortChipState copyWith({
    SortItem? selectedPlatform,
    List<SortItem>? platformSortList,
    bool clearPlatform = false,
  }) {
    return SortChipState(
      selectedPlatform: clearPlatform ? null : (selectedPlatform ?? this.selectedPlatform),
      platformSortList: platformSortList ?? this.platformSortList,
    );
  }

  @override
  List<Object?> get props => [
    selectedPlatform,
    platformSortList,
  ];
}