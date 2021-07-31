import 'package:masterstudy_app/data/models/BookResponse.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';

import 'package:meta/meta.dart';

@immutable
abstract class BookBookmarkState {}

class InitialBookmarkBookState extends BookBookmarkState {}

class LoadedBookmarkBookState extends BookBookmarkState {
  final List<CoursesBean> books;

  LoadedBookmarkBookState(this.books);
}

class ErrorBookmarkBookState extends BookBookmarkState {
  //final int categoryId;

  ErrorBookmarkBookState();
}
