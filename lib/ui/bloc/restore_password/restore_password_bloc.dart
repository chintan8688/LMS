import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/repository/auth_repository.dart';
import 'package:masterstudy_app/ui/bloc/restore_password/bloc.dart';

@provide
class RestorePasswordBloc
    extends Bloc<RestorePasswordEvent, RestorePasswordState> {
  final AuthRepository _authRepository;

  RestorePasswordBloc(this._authRepository);

  @override
  RestorePasswordState get initialState => InitialRestorePasswordState();

  @override
  Stream<RestorePasswordState> mapEventToState(
      RestorePasswordEvent event) async* {
    if (event is SendRestorePasswordEvent) {
      print('==: event call');
      try {
        yield LoadingRestorePasswordState();
        await _authRepository.restorePassword(event.email);
        print('==: repo call');
        yield SuccessRestorePasswordState();
        print('==: success');
      } catch (e, s) {
        print('==: catch block error');
        var errorData = json.decode(e.response.toString());
        print('==: ${errorData}');

        yield ErrorRestorePasswordState(errorData['message']);
      }
    }
  }
}
