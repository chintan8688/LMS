import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/models/instagram_feed.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeedState {}

class InitialFeedState extends FeedState {}

class LoadedFeedState extends FeedState {
  final InstagramFeedBean feeds;
  final Account account;

  LoadedFeedState(this.feeds, this.account);
}
