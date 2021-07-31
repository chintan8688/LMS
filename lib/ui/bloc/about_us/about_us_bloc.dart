import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/about_us_repository.dart';

import './bloc.dart';

@provide
class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  final AboutUsRepository _aboutUsRepository;

  AboutUsBloc(this._aboutUsRepository);

  @override
  AboutUsState get initialState => InitialAboutUsState();

  @override
  Stream<AboutUsState> mapEventToState(AboutUsEvent event) async* {
    if (event is FetchEvent) {
      yield InitialAboutUsState();
      try {
        var obj = await _aboutUsRepository.getAboutUs();
        yield LoadedAboutUsState(obj);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
      }
    }
  }
}
