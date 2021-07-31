import 'package:json_annotation/json_annotation.dart';

part 'BookCategory.g.dart';

@JsonSerializable()
class BookCategory {
  int id;
  String name;
  int count;

  BookCategory({this.id, this.name, this.count});

  factory BookCategory.fromJson(Map<String, dynamic> json) =>
      _$BookCategoryFromJson(json);
}
