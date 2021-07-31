import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/BookResponse.dart';

import 'package:masterstudy_app/data/repository/book_repository.dart';

import './bloc.dart';

@provide
class BookBookmarkBloc extends Bloc<BookBookmarkEvent, BookBookmarkState> {
  final BookRepository _bookRepository;

  BookBookmarkBloc(this._bookRepository);

  @override
  BookBookmarkState get initialState => InitialBookmarkBookState();

  @override
  Stream<BookBookmarkState> mapEventToState(BookBookmarkEvent event) async* {
    if (event is FetchBookmarkEvent) {
      yield InitialBookmarkBookState();
      try {
        var books = await _bookRepository.getBookmark();
        yield LoadedBookmarkBookState(books.courses);
      } catch (error, stackTrace) {
        print(stackTrace);
        yield ErrorBookmarkBookState();
      }
    }
  }
}
