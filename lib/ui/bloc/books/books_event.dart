import 'package:meta/meta.dart';

@immutable
abstract class BookEvent {}

class FetchEvent extends BookEvent {
  //final int categoryId;

  FetchEvent();
}

class FetchBookByIdEvent extends BookEvent {
  final int id;

  FetchBookByIdEvent(this.id);
}
