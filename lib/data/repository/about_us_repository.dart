import 'dart:ui';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/about_us.dart';
import 'package:masterstudy_app/data/models/instagram_feed.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';


abstract class AboutUsRepository {
  Future<AboutUsBean> getAboutUs();
}

@provide
@singleton
class AboutUsRepositoryImpl extends AboutUsRepository {
  final UserApiProvider apiProvider;

  AboutUsRepositoryImpl(this.apiProvider);

  @override
  Future<AboutUsBean> getAboutUs() {
    return apiProvider.getAboutUsInfo();
  }
}
