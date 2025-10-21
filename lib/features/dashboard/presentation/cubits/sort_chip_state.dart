part of 'sort_chip_cubit.dart';

class SortChipState extends Equatable {
  final bool filtering;
  final bool triggerFilter;
  final SortItem? selectedPlatform;
  final List<SortItem> platformSortList;

  const SortChipState({
    this.filtering = false,
    this.triggerFilter = false,
    this.selectedPlatform,
    this.platformSortList = const [],
  });

  SortChipState copyWith({
    bool? filtering,
    bool? triggerFilter,
    SortItem? selectedPlatform,
    List<SortItem>? platformSortList,
  }) {
    return SortChipState(
      filtering: filtering ?? this.filtering,
      triggerFilter: triggerFilter ?? this.triggerFilter,
      selectedPlatform: selectedPlatform ?? this.selectedPlatform,
      platformSortList: platformSortList ?? this.platformSortList,
    );
  }

  @override
  List<Object?> get props => [
    filtering,
    triggerFilter,
    selectedPlatform,
    platformSortList,
  ];

  @override
  bool get stringify => true;
}