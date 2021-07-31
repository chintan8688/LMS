import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/auth_repository.dart';

import './bloc.dart';

@provide
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository);

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is RegisterEvent) {
      yield* _mapRegisterEventToState(event);
    }
    if (event is LoginEvent) {
      yield* _mapSignInEventToState(event);
    }
    if (event is DemoAuthEvent) {
      yield* _mapDemoEventToState(event);
    }
    if (event is CloseDialogEvent) {
      yield InitialAuthState();
    }
    if (event is GoogleSignInEvent) {
      yield* _mapGoogleSignInEventToState(event);
    }
    if (event is FbLoginEvent) {
      yield* _mapFbLoginEventToState(event);
    }
    if (event is IosLoginEvent) {
      yield* _mapIosLoginEventToState(event);
    }
  }

  Stream<AuthState> _errorToState(message) async* {
    yield ErrorAuthState(message);
    //yield InitialAuthState();
  }

  Stream<AuthState> _mapRegisterEventToState(event) async* {
    yield LoadingAuthState();
    try {
      await _repository.register(
          event.login,
          event.email,
          event.password,
          event.phone,
          event.phone_code,
          event.country,
          event.birthDate,
          event.token);
      yield SuccessAuthState();
    } catch (error, stacktrace) {
      var errorData = json.decode(error.response.toString());
      print(('==: ${errorData}'));
      yield* _errorToState(errorData['message']);
    }
  }

  Stream<AuthState> _mapDemoEventToState(event) async* {
    yield LoadingAuthState();
    try {
      await _repository.demoAuth();
      yield SuccessAuthState();
    } catch (error, stacktrace) {
      var errorData = json.decode(error.response.toString());
      yield* _errorToState(errorData['message']);
    }
  }

  Stream<AuthState> _mapSignInEventToState(event) async* {
    yield LoadingAuthState();
    try {
      await _repository.authUser(
          event.login, event.password, event.device_token);
      yield SuccessAuthState();
    } catch (error, stacktrace) {
      var errorData = json.decode(error.response.toString());

      yield* _errorToState(errorData['message']);
    }
  }

  Stream<AuthState> _mapGoogleSignInEventToState(event) async* {
    yield LoadingAuthState();
    try {
      await _repository.googleSignIn(
          event.device_token, event.social_login_type);
      yield SuccessAuthState();
    } catch (error, stacktrace) {
      var errorData = json.decode(error.response.toString());
      yield* _errorToState(errorData['message']);
    }
  }

  Stream<AuthState> _mapFbLoginEventToState(event) async* {
    yield LoadingAuthState();
    try {
      await _repository.fbLogin(event.device_token, event.social_login_type);
      yield SuccessAuthState();
    } catch (error, stacktrace) {
      var errorData = json.decode(error.response.toString());
      yield* _errorToState(errorData['message']);
    }
  }

  Stream<AuthState> _mapIosLoginEventToState(event) async* {
    try {
      await _repository.iosLogin(event.device_token, event.social_login_type);
      yield SuccessAuthState();
    } catch (error, stacktrace) {
      var errorData = json.decode(error.response.toString());
      yield* _errorToState(errorData['message']);
    }
  }
}
