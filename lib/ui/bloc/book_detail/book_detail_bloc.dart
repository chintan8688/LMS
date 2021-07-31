import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/BookDetail.dart';

import 'package:masterstudy_app/data/repository/book_repository.dart';

import './bloc.dart';

@provide
class BookDetailBlock extends Bloc<BookDetailEvent, BookDetailState> {
  final BookRepository _bookRepository;
  BookDetails bookDetails;

  BookDetailBlock(this._bookRepository);

  @override
  BookDetailState get initialState => InitialBookDetailState();

  @override
  Stream<BookDetailState> mapEventToState(BookDetailEvent event) async* {
    if (event is FetchBookDetailEvent) {
      /*yield InitialBookDetailState();
      try {
        BookDetails books = await _bookRepository.getBook(event.bookId);
        yield LoadedBookDetailState(books);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        yield ErrorBookState();
      }*/
      yield* _mapFetchToState(event);
    } else if (event is AddBookToFavouriteEvent) {
      yield* _mapAddBookToFavouriteState(event);
    } else if (event is DeleteBookFromFavouriteEvent) {
      yield* _mapDeleteBookFromFavouriteState(event);
    } else if (event is RequestForBookEvent) {
      yield* _mapRequestBookToState(event);
    } else if (event is BookRatingEvent) {
      yield* _mapBookRatingToState(event);
    }
  }

  Stream<BookDetailState> _fetchBook(bookId) async* {
    if (bookDetails == null || state is ErrorBookState)
      yield InitialBookDetailState();
    try {
      bookDetails = await _bookRepository.getBook(bookId);

      yield LoadedBookDetailState(bookDetails);
    } catch (e, s) {
      print(e);
      print(s);
      yield ErrorBookState();
    }
  }

  Stream<BookDetailState> _mapFetchToState(FetchBookDetailEvent event) async* {
    yield* _fetchBook(event.bookId);
  }

  Stream<BookDetailState> _mapAddBookToFavouriteState(
      AddBookToFavouriteEvent event) async* {
    try {
      await _bookRepository.addToFavourite(event.id);
      //yield* _fetchBook(event.id);
    } catch (error) {
      print(error);
    }
  }

  Stream<BookDetailState> _mapDeleteBookFromFavouriteState(
      DeleteBookFromFavouriteEvent event) async* {
    try {
      await _bookRepository.deleteFavourite(event.id);
      //yield* _fetchBook(event.id);
    } catch (error) {
      print(error);
    }
  }

  Stream<BookDetailState> _mapRequestBookToState(
      RequestForBookEvent event) async* {
    yield* requestBook(event.id, event.notes);
  }

  Stream<BookDetailState> requestBook(id, notes) async* {
    try {
      await _bookRepository.requestForBook(id, notes);
      yield SuccessBookRequestState();
    } catch (e, s) {
      print(e);
      print(s);
      yield ErrorBookState();
    }
  }

  Stream<BookDetailState> _mapBookRatingToState(BookRatingEvent event) async* {
    yield* bookRating(event.id, event.rating);
  }

  Stream<BookDetailState> bookRating(id, rating) async* {
    try {
      await _bookRepository.giveRating(id, rating);
      yield SuccessRatingState();
    } catch (e, s) {
      print(e);
      print(s);
      yield ErrorBookState();
    }
  }
}
