part of 'BookResponse.dart';

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) {
  return BookResponse(
    page: json['page'] as num,
    totalPage: json['total_pages'] as num,
    book_bean: (json['courses'] as List)
        ?.map((e) =>
            e == null ? null : BookBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

BookBean _$BooksResponseFromJson(Map<String, dynamic> json) {
  return BookBean(
    id: json['id'] as num,
    title: json['title'] as String,
    image: json['images']['small'] as String,
    //isPremium: json['meta']['is_premium'] as String,
    //subtitle: json['subtitle'] as String,
    //isBookmark: json['is_bookmark'] as String,
    ratingBean: json['rating'] == null
        ? null
        : RatingBean.fromJson(json['rating'] as Map<String, dynamic>),
  );
}

RatingBean _$RatingBeanFromJson(Map<String, dynamic> json) {
  return RatingBean(
    total: json['total'] as num,
    average: json['average'] as num,
    percent: json['percent'] as num,
  );
}
