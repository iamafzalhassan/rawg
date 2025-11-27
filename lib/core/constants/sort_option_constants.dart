import 'package:easy_localization/easy_localization.dart';
import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

class SortOptionConstants {
  static List<SortItem> get platforms => [
    SortItem(isSelected: false, name: 'sort.playstation'.tr(), value: '18,16,15,27,19,17,14,80', id: 1),
    SortItem(isSelected: false, name: 'sort.xbox'.tr(), value: '1,186,14,80', id: 2),
    SortItem(isSelected: false, name: 'sort.pc'.tr(), value: '4', id: 3),
  ];
}