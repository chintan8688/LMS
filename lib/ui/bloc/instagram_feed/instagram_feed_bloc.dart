import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/models/instagram_feed.dart';
import 'package:masterstudy_app/data/repository/account_repository.dart';
import 'package:masterstudy_app/data/repository/instagram_feed_repository.dart';

import './bloc.dart';

@provide
class FeedBlock extends Bloc<FeedEvent, FeedState> {
  final FeedRepository _feedRepository;
  final AccountRepository _accountRepository;

  FeedBlock(this._feedRepository, this._accountRepository);

  @override
  FeedState get initialState => InitialFeedState();

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    if (event is FetchEvent) {
      yield InitialFeedState();
      try {
        InstagramFeedBean feed = await _feedRepository.getIgFeed();
        Account account = await _accountRepository.getUserAccount();
        yield LoadedFeedState(feed, account);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
      }
    }
  }
}
