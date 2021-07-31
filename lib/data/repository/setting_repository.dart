import 'dart:ui';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/settings.dart';

import 'package:masterstudy_app/data/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masterstudy_app/data/utils.dart';

abstract class SettingRepository {
  Future sendBug(String bugs);

  Future<SettingsBean> getSettings();

  Future setNotification(int isNotification);
}

@provide
@singleton
class SettingRepositoryImpl extends SettingRepository {
  final UserApiProvider apiProvider;

  SettingRepositoryImpl(this.apiProvider);

  @override
  Future sendBug(String bugs) {
    return apiProvider.sendBugs(bugs);
  }

  @override
  Future<SettingsBean> getSettings() {
    return apiProvider.getSetting();
  }

  @override
  Future setNotification(int isNotification) {
    return apiProvider.setNotificationSetting(isNotification);
  }
}
