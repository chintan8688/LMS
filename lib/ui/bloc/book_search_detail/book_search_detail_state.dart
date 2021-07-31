import 'package:masterstudy_app/data/models/BookResponse.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookSearchDetailState {}

class InitialSearchDetailState extends BookSearchDetailState {}

class LoadingSearchDetailState extends BookSearchDetailState {}

class LoadedSearchDetailState extends BookSearchDetailState {
  final List<BookBean> books;

  LoadedSearchDetailState(this.books);
}

class NotingFoundSearchDetailState extends BookSearchDetailState {}

class ErrorSearchDetailState extends BookSearchDetailState {}
