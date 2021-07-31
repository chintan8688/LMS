import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AboutUsBean {
  String url;
  String title;

  AboutUsBean({this.url, this.title});

  factory AboutUsBean.fromJson(Map<String, dynamic> json) {
    return AboutUsBean(
        url: json['description'] as String, title: json['title'] as String);
  }
}
