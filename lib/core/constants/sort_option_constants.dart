import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';

class SortOptionConstants {
  static final general = [
    SortItem(id: 1, name: 'Relevance', isSelected: true, value: ''),
    SortItem(id: 2, name: 'Date added', isSelected: false, value: '-added'),
    SortItem(id: 3, name: 'Name', isSelected: false, value: 'name'),
    SortItem(id: 4, name: 'Release date', isSelected: false, value: '-released'),
    SortItem(id: 5, name: 'Popularity', isSelected: false, value: '-rating'),
    SortItem(id: 6, name: 'Average rating', isSelected: false, value: '-metacritic'),
  ];

  static final platforms = [
    SortItem(id: 1, name: 'PlayStation', isSelected: false, value: '18,16,15,27,19,17,14,80'),
    SortItem(id: 2, name: 'Xbox', isSelected: false, value: '1,186,14,80'),
    SortItem(id: 3, name: 'PC', isSelected: false, value: '4'),
  ];
}