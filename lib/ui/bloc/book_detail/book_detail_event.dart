import 'package:meta/meta.dart';

@immutable
abstract class BookDetailEvent {}

class FetchBookDetailEvent extends BookDetailEvent {
  final int bookId;

  FetchBookDetailEvent(this.bookId);
}

class AddBookToFavouriteEvent extends BookDetailEvent {
  final int id;

  AddBookToFavouriteEvent(this.id);
}

class DeleteBookFromFavouriteEvent extends BookDetailEvent {
  final int id;

  DeleteBookFromFavouriteEvent(this.id);
}

class RequestForBookEvent extends BookDetailEvent {
  final int id;
  final String notes;

  RequestForBookEvent(this.id, this.notes);
}

class BookRatingEvent extends BookDetailEvent {
  final int id;
  final num rating;

  BookRatingEvent(this.id, this.rating);
}
