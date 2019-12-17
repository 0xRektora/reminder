import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../features/login/domain/usecases/login_from_cache.dart';
import '../usecases/usecase.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  LoginFromCacheUseCase loginFromCacheUseCase;

  @override
  AppState get initialState => InitialAppState();

  AppBloc({
    @required this.loginFromCacheUseCase,
  }) {
    this.add(CAppLoadLoginUserFromCacheEvent());
  }
  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppLoggedEvent) {
      yield AppLoggedState(event.user);
    }
    if (event is CAppLoadLoginUserFromCacheEvent) {
      print("Loading from cache");
      yield CAppLoadingLoginState();
      final usecase = await loginFromCacheUseCase(NoParams());
      yield* usecase.fold(
        (failure) async* {
          yield ErrorAppState(message: "Can't login");
        },
        (user) async* {
          yield AppLoggedState(user);
        },
      );
    }
  }
}
