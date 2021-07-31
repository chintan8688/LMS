import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {
  final Account account;
  final List<CountryDropdown> countries;

  LoadedProfileState(this.account, this.countries);
}

class LogoutProfileState extends ProfileState {}

class UpdateSuccessState extends ProfileState {
  UpdateSuccessState();
}

class SuccessUpdateState extends ProfileState {
  final response;

  SuccessUpdateState(this.response);
}


