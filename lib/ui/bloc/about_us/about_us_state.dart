import 'package:masterstudy_app/data/models/about_us.dart';

import 'package:meta/meta.dart';

@immutable
abstract class AboutUsState {}

class InitialAboutUsState extends AboutUsState {}

class LoadedAboutUsState extends AboutUsState {
  final AboutUsBean bean;

  LoadedAboutUsState(this.bean);
}
