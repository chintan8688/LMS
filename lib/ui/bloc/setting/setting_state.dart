import 'package:masterstudy_app/data/models/settings.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SettingState {}

class IntialSettingState extends SettingState {}

class LoadedSettingState extends SettingState {
  final SettingsBean bean;
  LoadedSettingState(this.bean);
}
