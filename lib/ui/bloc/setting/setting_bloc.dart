import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/setting_repository.dart';

import './bloc.dart';

@provide
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingRepository _settingRepository;

  SettingBloc(this._settingRepository);

  @override
  SettingState get initialState => IntialSettingState();

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is FetchEvent) {
      yield IntialSettingState();
      try {
        var setting = await _settingRepository.getSettings();
        yield LoadedSettingState(setting);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
      }
    } else if (event is SendBugEvent) {
      try {
        await _settingRepository.sendBug(event.bugs);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
      }
    } else if (event is SetSettingEvent) {
      try {
        await _settingRepository.setNotification(event.isNotification);
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
      }
    }
  }
}
