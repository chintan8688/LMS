import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class InstagramFeedBean {
  List<DataBean> data;

  InstagramFeedBean({this.data});

  factory InstagramFeedBean.fromJson(Map<String, dynamic> json) {
    return InstagramFeedBean(
        data: (json['data'] as List)
            ?.map((e) => DataBean.fromJson(e as Map<String, dynamic>))
            ?.toList());
  }
}

class DataBean {
  String url;

  DataBean({this.url});

  factory DataBean.fromJson(Map<String, dynamic> json) {
    return DataBean(url: json['media_url'] as String);
  }
}
