import 'package:easy_localization/easy_localization.dart';
import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

class SortOptionConstants {
  static List<SortItem> get general => [
    SortItem(true, 1, 'sort.relevance'.tr(), ''),
    SortItem(false, 2, 'sort.dateAdded'.tr(), '-added'),
  ];

  static List<SortItem> get platforms => [
    SortItem(false, 1, 'sort.playstation'.tr(), '18,16,15,27,19,17,14,80'),
    SortItem(false, 2, 'sort.xbox'.tr(), '1,186,14,80'),
    SortItem(false, 3, 'sort.pc'.tr(), '4'),
  ];
}