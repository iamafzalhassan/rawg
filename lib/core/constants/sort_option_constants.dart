import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

class SortOptionConstants {
  static final general = [
    SortItem(id: 1, name: 'Relevance', isSelected: true),
    SortItem(id: 2, name: 'Date added', isSelected: false),
    SortItem(id: 3, name: 'Name', isSelected: false),
    SortItem(id: 4, name: 'Release date', isSelected: false),
    SortItem(id: 5, name: 'Popularity', isSelected: false),
    SortItem(id: 6, name: 'Average rating', isSelected: false),
  ];

  static final platforms = [
    SortItem(id: 1, name: 'PlayStation', isSelected: false),
    SortItem(id: 2, name: 'Xbox', isSelected: false),
    SortItem(id: 3, name: 'PC', isSelected: false),
  ];
}