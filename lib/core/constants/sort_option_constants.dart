import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

class SortOptionConstants {
  static final general = [
    SortItem(true, 1, 'Relevance', ''),
    SortItem(false, 2, 'Date added', '-added'),
  ];

  static final platforms = [
    SortItem(false, 1, 'PlayStation', '18,16,15,27,19,17,14,80'),
    SortItem(false, 2, 'Xbox', '1,186,14,80'),
    SortItem(false, 3, 'PC', '4'),
  ];
}