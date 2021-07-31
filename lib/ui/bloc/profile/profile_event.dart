import 'dart:io';

import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  String f_name,
      l_name,
      email,
      phoneCode,
      phone,
      country,
      password,
      oldPassword;
  DateTime bDate;
  File image;

  UpdateProfileEvent(
      this.f_name,
      this.l_name,
      this.email,
      this.phoneCode,
      this.phone,
      this.country,
      this.bDate,
      this.password,
      this.oldPassword,
      this.image);
}

class LogoutProfileEvent extends ProfileEvent {}

class CloseDialogEvent extends ProfileEvent {}
