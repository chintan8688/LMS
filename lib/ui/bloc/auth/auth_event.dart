import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class DeomAuthEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String login;
  final String password;
  final String device_token;

  LoginEvent(this.login, this.password, this.device_token);
}

class RegisterEvent extends AuthEvent {
  final String login;
  final String email;
  final String password;
  final String phone_code;
  final String phone;
  final String country;
  final DateTime birthDate;
  final String token;

  RegisterEvent(this.login, this.email, this.password, this.phone,
      this.phone_code, this.country, this.birthDate, this.token);
}

class CloseDialogEvent extends AuthEvent {}

class DemoAuthEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {
  final String device_token;
  final String social_login_type;

  GoogleSignInEvent(this.device_token, this.social_login_type);
}

class FbLoginEvent extends AuthEvent {
  final String device_token;
  final String social_login_type;

  FbLoginEvent(this.device_token, this.social_login_type);
}

class IosLoginEvent extends AuthEvent {
  final String device_token;
  final String social_login_type;

  IosLoginEvent(this.device_token, this.social_login_type);
}
