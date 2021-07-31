import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/LessonResponse.dart';
import 'package:masterstudy_app/data/repository/lesson_repository.dart';

import './bloc.dart';

@provide
class LessonAudioBloc extends Bloc<LessonAudioEvent, LessonAudioState> {
  final LessonRepository _lessonRepository;

  LessonAudioBloc(this._lessonRepository);

  @override
  LessonAudioState get initialState => InitialLessonAudioState();

  @override
  Stream<LessonAudioState> mapEventToState(
      LessonAudioEvent event,
      ) async* {
    if (event is FetchEvent) {
      try {

        LessonResponse response = await _lessonRepository.getLesson(event.courseId, event.lessonId);

        yield LoadedLessonAudioState(response);
      } catch(error) {
        print(error);
      }
    }else if (event is CompleteLessonEvent){
      try{
        var response = await _lessonRepository.completeLesson(event.courseId, event.lessonId);
      }catch(e,s){
        print(e);
        print(s);
      }
    }
  }
}
