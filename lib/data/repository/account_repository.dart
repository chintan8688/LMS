import 'dart:io';

import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AccountRepository {
  Future<Account> getUserAccount();

  Future<Account> getAccountById(int userId);

  Future editProfile(
      String f_name,
      String l_name,
      String email,
      String password,
      String oldPassword,
      String phone,
      String phoneCode,
      DateTime bDate,
      String country,
      {File photo});
}

@provide
class AccountRepositoryImpl implements AccountRepository {
  final UserApiProvider _apiProvider;

  AccountRepositoryImpl(this._apiProvider);

  @override
  Future<Account> getAccountById(int accountId) {
    return _apiProvider.getAccount(accountId: accountId);
  }

  @override
  Future<Account> getUserAccount() {
    return _apiProvider.getAccount();
  }

  @override
  Future editProfile(
      String f_name,
      String l_name,
      String email,
      String password,
      String oldPassword,
      String phone,
      String phoneCode,
      DateTime bDate,
      String country,
      {File photo}) async {
    var response = await _apiProvider.editProfile(f_name, l_name, email,
        password, oldPassword, phone, phoneCode, bDate, country);
    if (photo != null) {
      var response = await _apiProvider.uploadProfilePhoto(photo);
      String avatarUrl = response['user']['avatar_url'];
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString("avatarUrl", avatarUrl);
    }
    return response;
  }
}
