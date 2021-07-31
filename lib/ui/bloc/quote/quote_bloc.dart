import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/quote_repository.dart';

import './bloc.dart';

@provide
class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository _quoteRepository;

  QuoteBloc(this._quoteRepository);

  @override
  QuoteState get initialState => InitialQuoteState();

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async* {
    if (event is FetchEvent) {
      yield InitialQuoteState();
      try {
        var obj = await _quoteRepository.getQuote();
        yield LoadedQuoteState(obj);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
      }
    }
  }
}
