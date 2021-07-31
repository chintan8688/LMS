import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/BookResponse.dart';
import 'package:masterstudy_app/data/models/course/CourcesResponse.dart';
import 'package:masterstudy_app/data/repository/book_repository.dart';
import 'package:masterstudy_app/data/repository/courses_repository.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

@provide
class BookSearchDetailBloc
    extends Bloc<BookSearchDetailEvent, BookSearchDetailState> {
  final BookRepository _bookRepository;

  BookSearchDetailBloc(this._bookRepository);

  @override
  BookSearchDetailState get initialState => InitialSearchDetailState();

  @override
  Stream<BookSearchDetailState> transformEvents(
    Stream<BookSearchDetailEvent> events,
    Stream<BookSearchDetailState> Function(BookSearchDetailEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  void onTransition(
      Transition<BookSearchDetailEvent, BookSearchDetailState> transition) {}

  @override
  Stream<BookSearchDetailState> mapEventToState(
    BookSearchDetailEvent event,
  ) async* {
    if (event is FetchEvent) {
      if (event.query.isNotEmpty) {
        try {
          yield LoadingSearchDetailState();
          BookResponse response = await _bookRepository.getSerchedBookDetail(
              searchQuery: event.query);
          yield LoadedSearchDetailState(response.book_bean);
        } catch (error, stacktrace) {
          print(error);
          print(stacktrace);
          yield NotingFoundSearchDetailState();
        }
      }
    }
  }
}
