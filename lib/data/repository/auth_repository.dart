import 'dart:convert';
import 'dart:developer';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/cache/cache_manager.dart';
import 'package:masterstudy_app/data/models/auth.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future authUser(String login, String password, String token);

  Future register(String login, String email, String password, String phone,
      String phone_code, String country, DateTime birthDate, String token);

  Future restorePassword(String email);

  Future demoAuth();

  Future<String> getToken();

  Future<bool> isSigned();

  Future logout();

  Future googleSignIn(String device_token, String social_login_type);

  Future fbLogin(String device_token, String login_type);

  Future iosLogin(String device_token, String login_type);

  Future<List<CountryDropdown>> getCountries();
}

@provide
@singleton
class AuthRepositoryImpl extends AuthRepository {
  final facebookLogin = FacebookLogin();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  final UserApiProvider provider;
  final SharedPreferences _sharedPreferences;
  static const tokenKey = "apiToken";
  static const avatarUrl = "avatarUrl";

  AuthRepositoryImpl(this.provider, this._sharedPreferences);

  @override
  Future authUser(String login, String password, String token) async {
    AuthResponse response = await provider.authUser(login, password, token);
    _saveToken(response.token);
    _saveProfilePicture(response.url);
  }

  @override
  Future register(
      String login,
      String email,
      String password,
      String phone,
      String phone_code,
      String country,
      DateTime birthDate,
      String token) async {
    AuthResponse response = await provider.signUpUser(
        login, email, password, phone, phone_code, country, birthDate, token);
    _saveToken(response.token);
    _saveProfilePicture(response.url);
  }

  @override
  Future<String> getToken() {
    return Future.value(_sharedPreferences.getString(tokenKey));
  }

  void _saveToken(String token) {
    _sharedPreferences.setString(tokenKey, token);
  }

  void _saveProfilePicture(String url) {
    _sharedPreferences.setString(avatarUrl, url);
  }

  @override
  Future<bool> isSigned() {
    var token = _sharedPreferences.getString(tokenKey);
    if (token != null && token.isNotEmpty) return Future.value(true);
    return Future.value(false);
  }

  @override
  Future logout() async {
    _sharedPreferences.setString("apiToken", "");
    _sharedPreferences.setString("avatarUrl", "");
    await CacheManager().cleanCache();
  }

  @override
  Future demoAuth() async {
    var token = await provider.demoAuth();
    _saveToken(token);
  }

  @override
  Future restorePassword(String email) async {
    await provider.restorePassword(email);
  }

  @override
  Future googleSignIn(String device_token, String social_login_type) async {
    String token;
    await _googleSignIn.signIn().then((value) =>
        value.authentication.then((value) => {token = value.idToken}));

    String email = _googleSignIn.currentUser.email;
    String name = _googleSignIn.currentUser.displayName;
    String id = _googleSignIn.currentUser.id;
    String avtar_url = _googleSignIn.currentUser.photoUrl;
    AuthResponse response = await provider.socialLogin(
        device_token, social_login_type, email, name, id, avtar_url);
    _saveToken(response.token);
    _saveProfilePicture(response.url);
  }

  @override
  Future fbLogin(String device_token, String login_type) async {
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);
    final profile = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=${result.accessToken.token}');
    var user_data = json.decode(profile.body);
    String url =
        'https://graph.facebook.com/${user_data['id']}/picture?height=300&width=300';
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        AuthResponse response = await provider.socialLogin(
            device_token,
            login_type,
            user_data['email'],
            user_data['name'],
            user_data['id'],
            url);
        _saveToken(response.token);
        _saveProfilePicture(response.url);
        break;
      case FacebookLoginStatus.error:
        print('DATA: ${result.errorMessage}');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('DATA: cancel');
        break;
    }
  }

  @override
  Future iosLogin(String device_token, String login_type) {}

  @override
  Future<List<CountryDropdown>> getCountries() {
    return provider.getCountry();
  }
}
