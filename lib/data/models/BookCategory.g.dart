part of 'BookCategory.dart';

    BookCategory _$BookCategoryFromJson(Map<String,dynamic> json){
          return BookCategory(
            id: json['id'] as num,
            count: json['count'] as num,
            name: json['name'] as String
          );
    }