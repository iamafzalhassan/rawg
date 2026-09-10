part of 'sort_chip_cubit.dart';

class SortChipState extends Equatable {
  final bool filtering;
  final bool triggerFilter;

  final List<SortItem> platformSortList;

  final SortItem? selectedPlatform;

  const SortChipState({this.filtering = false, this.triggerFilter = false, this.platformSortList = const [], this.selectedPlatform});

  SortChipState copyWith({bool? filtering, bool? triggerFilter, List<SortItem>? platformSortList, SortItem? selectedPlatform}) =>
      SortChipState(filtering: filtering ?? this.filtering, triggerFilter: triggerFilter ?? this.triggerFilter, platformSortList: platformSortList ?? this.platformSortList, selectedPlatform: selectedPlatform ?? this.selectedPlatform);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [filtering, triggerFilter, platformSortList, selectedPlatform];
}
