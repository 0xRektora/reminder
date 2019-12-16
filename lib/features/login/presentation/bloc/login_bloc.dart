import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/error/failures.dart';
import 'package:reminder/core/usecases/usecase.dart';
import 'package:reminder/features/login/domain/usecases/login_from_cache.dart';
import 'package:reminder/features/login/domain/usecases/login_with_google.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithGoogle loginWithGoogle;
  final LoginFromCacheUseCase loginFromCacheUseCase;

  LoginBloc(
      {@required this.loginWithGoogle, @required this.loginFromCacheUseCase});

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
          yield LoadingLoginState();
          yield LoadedLoginFromCacheState(user: user);
        },
      );
    }
    if (event is LoadedLoginFromCacheState) {
      final usecase = await loginFromCacheUseCase(NoParams());
      yield* usecase.fold(
        (failure) async* {
          yield ErrorLoginState(message: "Can't login");
        },
        (user) async* {
          yield LoadingLoginState();
          yield LoadedLoginState(user: user);
        },
      );
    }
  }
}
