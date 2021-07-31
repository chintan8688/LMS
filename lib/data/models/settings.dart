import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SettingsBean {
  int isNotification;
  List<FaqBean> faqs;

  SettingsBean({this.isNotification, this.faqs});

  factory SettingsBean.fromJson(Map<String, dynamic> json) {
    return SettingsBean(
        isNotification: json['allow_notification'] as int,
        faqs: (json['FAQs'] as List)
            ?.map((e) =>
                e == null ? null : FaqBean.fromJson(e as Map<String, dynamic>))
            ?.toList());
  }
}

@JsonSerializable()
class FaqBean {
  int id;
  String title, contetnt;

  FaqBean({this.id, this.title, this.contetnt});

  factory FaqBean.fromJson(Map<String, dynamic> json) {
    return FaqBean(
        id: json['id'] as int,
        title: json['title'] as String,
        contetnt: json['content'] as String);
  }
}
