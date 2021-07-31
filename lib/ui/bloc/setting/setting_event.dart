import 'package:meta/meta.dart';

@immutable
abstract class SettingEvent {}

class FetchEvent extends SettingEvent {
  FetchEvent();
}

class SendBugEvent extends SettingEvent {
  String bugs;

  SendBugEvent(this.bugs);
}

class SuccessSentEvent extends SettingEvent {
  SuccessSentEvent();
}

class SetSettingEvent extends SettingEvent {
  int isNotification;

  SetSettingEvent(this.isNotification);
}
