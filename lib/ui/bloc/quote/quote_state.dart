import 'package:masterstudy_app/data/models/quote.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuoteState {}

class InitialQuoteState extends QuoteState {}

class LoadedQuoteState extends QuoteState {
  final QuoteBean bean;

  LoadedQuoteState(this.bean);
}
