import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';

import 'package:masterstudy_app/data/repository/book_repository.dart';

import './bloc.dart';

@provide
class BookBlock extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository;

  BookBlock(this._bookRepository);

  @override
  BookState get initialState => InitialBookState();

  @override
  Stream<BookState> mapEventToState(BookEvent event) async* {
    if (event is FetchEvent) {
      yield InitialBookState();
      try {
        var book_category = await _bookRepository.getCategories();
        var books = await _bookRepository.getBooks();
        yield LoadedBookState(books.courses, book_category);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        yield ErrorBookState();
      }
    } else if (event is FetchBookByIdEvent) {
      yield InitialBookState();
      try {
        var book_category = await _bookRepository.getCategories();
        var books = await _bookRepository.getBooksById(event.id);
        yield LoadedBookState(books.courses, book_category);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        yield ErrorBookState();
      }
    }
  }
}
