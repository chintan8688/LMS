import 'package:meta/meta.dart';

@immutable
abstract class AboutUsEvent {}

class FetchEvent extends AboutUsEvent {
  FetchEvent();
}
