import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/static/c_s_shared_prefs.dart';
import 'package:reminder/core/usecases/usecase.dart';
import 'package:reminder/features/login/domain/usecases/login_with_google.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithGoogle loginWithGoogle;

  LoginBloc({@required this.loginWithGoogle});

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoadLoginUserEvent) {
      final usecase = await loginWithGoogle(NoParams());
      yield* usecase.fold(
        (failure) async* {
          yield ErrorLoginState(message: "Can't login");
        },
        (user) async* {
          yield FLoginLoadingLoginState();
          yield LoadedLoginState(user: user);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(CSSharedPrefs.LOGGED_IN, true);
        },
      );
    }
  }
}
