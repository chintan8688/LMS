import 'package:meta/meta.dart';

@immutable
abstract class BookBookmarkEvent {}

class FetchBookmarkEvent extends BookBookmarkEvent {
  //final int categoryId;

  FetchBookmarkEvent();
}

class FetchBookByIdEvent extends BookBookmarkEvent {
  final int id;

  FetchBookByIdEvent(this.id);
}
