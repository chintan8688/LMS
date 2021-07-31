import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/repository/account_repository.dart';
import 'package:masterstudy_app/data/repository/auth_repository.dart';

import './bloc.dart';

@provide
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountRepository _accountRepository;
  final AuthRepository _authRepository;

  Account account;

  ProfileBloc(this._accountRepository, this._authRepository);

  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfileEvent) {
      yield InitialProfileState();
      yield* _mapFetchToState(event);
    }
    if (event is UpdateProfileEvent) {
      yield* _mapUpdateToState(event);
    }
    if (event is LogoutProfileEvent) {
      await _authRepository.logout();
      yield LogoutProfileState();
    }
    if (event is CloseDialogEvent) {
      yield InitialProfileState();
    }
  }

  Stream<ProfileState> _mapFetchToState(event) async* {
    try {
      Account account = await _accountRepository.getUserAccount();
      var countries = await _authRepository.getCountries();
      yield LoadedProfileState(account, countries);
    } catch (excaption, stacktrace) {
      print(excaption);
      print(stacktrace);
    }
  }

  Stream<ProfileState> _mapUpdateToState(event) async* {
    try {
      var response = await _accountRepository.editProfile(
          event.f_name,
          event.l_name,
          event.email,
          event.password,
          event.oldPassword,
          event.phone,
          event.phoneCode,
          event.bDate,
          event.country,
          photo: event.image);
      yield SuccessUpdateState(response);
    } catch (excaption, stacktrace) {
      print(excaption);
      print(stacktrace);
    }
  }
}
