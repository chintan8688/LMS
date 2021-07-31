import 'package:meta/meta.dart';

@immutable
abstract class QuoteEvent {}

class FetchEvent extends QuoteEvent {
  FetchEvent();
}