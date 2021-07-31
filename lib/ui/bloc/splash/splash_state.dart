import 'package:masterstudy_app/data/models/AppSettings.dart';
import 'package:masterstudy_app/data/models/country_dropdown.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashState {}

class InitialSplashState extends SplashState {}

class CloseSplash extends SplashState {
  final bool isSigned;
  final AppSettings appSettings;
  final List<CountryDropdown> countries;

  CloseSplash(this.isSigned, this.appSettings,this.countries);
}

class ErrorSplashState extends SplashState {}

