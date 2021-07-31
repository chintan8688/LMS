import 'package:meta/meta.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState(this.message);
}
