import 'package:meta/meta.dart';

@immutable
abstract class LessonAudioEvent {}

class FetchEvent extends LessonAudioEvent {
  final int courseId;
  final int lessonId;

  FetchEvent(this.courseId, this.lessonId);
}
class CompleteLessonEvent extends LessonAudioEvent {
  final int courseId;
  final int lessonId;

  CompleteLessonEvent(this.courseId, this.lessonId);
}
