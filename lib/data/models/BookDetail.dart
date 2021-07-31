import 'package:json_annotation/json_annotation.dart';

part 'BookDetail.g.dart';

@JsonSerializable()
class BookDetails {
  int id;
  String title;
  String description;
  String subtitle;
  String isBookmark;
  String message;

  BookDetails({this.id, this.title, this.description,this.subtitle,this.isBookmark});

  factory BookDetails.fromJson(Map<String, dynamic> json) =>
      _$BookDetailFromJson(json);
}
