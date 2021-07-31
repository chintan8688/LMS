import 'package:masterstudy_app/ui/bloc/restore_password/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RestorePasswordState {}

class InitialRestorePasswordState extends RestorePasswordState {}

class LoadingRestorePasswordState extends RestorePasswordState {}

class SuccessRestorePasswordState extends RestorePasswordState {}

class ErrorRestorePasswordState extends RestorePasswordState {
  final String error;

  ErrorRestorePasswordState(this.error);
}
