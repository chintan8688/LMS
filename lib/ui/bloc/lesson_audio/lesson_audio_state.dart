import 'package:masterstudy_app/data/models/LessonResponse.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LessonAudioState {}

class InitialLessonAudioState extends LessonAudioState {}

class LoadedLessonAudioState extends LessonAudioState {
  final LessonResponse lessonResponse;

  LoadedLessonAudioState(this.lessonResponse);
}
