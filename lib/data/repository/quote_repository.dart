import 'dart:ui';
import 'package:inject/inject.dart';

import 'package:masterstudy_app/data/models/quote.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';


abstract class QuoteRepository {
  Future<QuoteBean> getQuote();
}

@provide
@singleton
class QuoteRepositoryImpl extends QuoteRepository {
  final UserApiProvider apiProvider;

  QuoteRepositoryImpl(this.apiProvider);

  @override
  Future<QuoteBean> getQuote() {
    return apiProvider.getQuotes();
  }
}
