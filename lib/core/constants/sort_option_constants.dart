import 'package:easy_localization/easy_localization.dart';
import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

class SortOptionConstants {
  static List<SortItem> get platforms => [
    SortItem(false, 'sort.playstation'.tr(), '18,16,15,27,19,17,14,80', 1),
    SortItem(false, 'sort.xbox'.tr(), '1,186,14,80', 2),
    SortItem(false, 'sort.pc'.tr(), '4', 3),
  ];
}