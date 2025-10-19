part of 'sort_chip_cubit.dart';

class SortChipState extends Equatable {
  final SortItem? selectedPlatform;
  final List<SortItem> platformSortList;
  final bool isFiltering;
  final bool shouldTriggerFilter;

  const SortChipState({
    this.selectedPlatform,
    this.platformSortList = const [],
    this.isFiltering = false,
    this.shouldTriggerFilter = false,
  });

  SortChipState copyWith({
    SortItem? selectedPlatform,
    List<SortItem>? platformSortList,
    bool? isFiltering,
    bool? shouldTriggerFilter,
  }) {
    return SortChipState(
      selectedPlatform: selectedPlatform ?? this.selectedPlatform,
      platformSortList: platformSortList ?? this.platformSortList,
      isFiltering: isFiltering ?? this.isFiltering,
      shouldTriggerFilter: shouldTriggerFilter ?? this.shouldTriggerFilter,
    );
  }

  @override
  List<Object?> get props => [
    selectedPlatform,
    platformSortList,
    isFiltering,
    shouldTriggerFilter,
  ];

  @override
  bool get stringify => true;
}