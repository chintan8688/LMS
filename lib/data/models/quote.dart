import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class QuoteBean {
  String quote;
  String title;

  QuoteBean({this.quote, this.title});

  factory QuoteBean.fromJson(Map<String, dynamic> json) {
    return QuoteBean(
        quote: json['description'] as String, title: json['title'] as String);
  }
}
