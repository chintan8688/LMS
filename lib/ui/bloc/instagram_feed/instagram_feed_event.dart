import 'package:meta/meta.dart';

@immutable
abstract class FeedEvent {}

class FetchEvent extends FeedEvent {
  FetchEvent();
}
