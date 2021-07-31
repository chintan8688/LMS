import 'package:meta/meta.dart';

@immutable
abstract class BookSearchDetailEvent {}

class FetchEvent extends BookSearchDetailEvent {
  final String query;

  FetchEvent(this.query);
}
