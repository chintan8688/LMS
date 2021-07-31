import 'dart:ui';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/instagram_feed.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masterstudy_app/data/utils.dart';

abstract class FeedRepository {
  Future<InstagramFeedBean> getIgFeed();
}

@provide
@singleton
class FeedRepositoryImpl extends FeedRepository {
  final UserApiProvider apiProvider;

  FeedRepositoryImpl(this.apiProvider);

  @override
  Future<InstagramFeedBean> getIgFeed() {
    return apiProvider.getInstaFeeds();
  }
}
