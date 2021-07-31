import 'package:masterstudy_app/data/models/BookDetail.dart';
import 'package:masterstudy_app/ui/bloc/book_detail/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookDetailState {}

class InitialBookDetailState extends BookDetailState {}

class LoadedBookDetailState extends BookDetailState {
  final BookDetails bookDetail;

  LoadedBookDetailState(this.bookDetail);
}

class ErrorBookState extends BookDetailState {
  ErrorBookState();
}

class SuccessBookRequestState extends BookDetailState {
  SuccessBookRequestState();
}

class SuccessRatingState extends BookDetailState {
  SuccessRatingState();
}
