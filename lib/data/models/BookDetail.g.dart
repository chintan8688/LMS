part of 'BookDetail.dart';

BookDetails _$BookDetailFromJson(Map<String, dynamic> json) {
  return BookDetails(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      //subtitle: json['meta']['subtitle'] as String,
      //isBookmark: json['is_bookmark'] as String
  );
}
