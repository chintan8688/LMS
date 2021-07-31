import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:masterstudy_app/data/models/course/CourseDetailResponse.dart';

part 'BookResponse.g.dart';

@JsonSerializable()
class BookResponse {
  num page;
  List<BookBean> book_bean;
  num totalPage;

  BookResponse({this.page, this.book_bean, this.totalPage});

  factory BookResponse.fromJson(Map<String, dynamic> json) =>
      _$BookResponseFromJson(json);
}

@JsonSerializable()
class BookBean {
  num id;
  String title;

  String image;

  String subtitle;

  String isPremium;

  String isBookmark;

  RatingBean ratingBean;

  BookBean(
      {this.id,
      this.title,
      this.image,
      this.isPremium,
      this.subtitle,
      this.isBookmark,
      this.ratingBean});

  factory BookBean.fromJson(Map<String, dynamic> json) =>
      _$BooksResponseFromJson(json);
}

@JsonSerializable()
class RatingBean {
  num total;
  num average;
  num percent;
  DetailsBean details;

  RatingBean({this.total, this.average, this.percent, this.details});

  factory RatingBean.fromJson(Map<String, dynamic> json) =>
      _$RatingBeanFromJson(json);
}
