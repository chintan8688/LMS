import 'package:masterstudy_app/data/models/BookCategory.dart';
import 'package:masterstudy_app/data/models/BookResponse.dart';
import 'package:masterstudy_app/data/models/category.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:meta/meta.dart';

import '../../../data/models/course/CourcesResponse.dart';

@immutable
abstract class BookState {}

class InitialBookState extends BookState {}

class LoadedBookState extends BookState {
  //final List<Category> categoryList;
  //final List<CoursesBean> courses;

  final List<CoursesBean> books;
  final List<BookCategory> category;

  LoadedBookState(this.books, this.category);
}

class ErrorBookState extends BookState {
  //final int categoryId;

  ErrorBookState();
}
