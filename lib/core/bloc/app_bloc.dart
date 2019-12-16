import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/usecases/usecase.dart';
import 'package:reminder/features/login/domain/usecases/login_from_cache.dart';
import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  LoginFromCacheUseCase loginFromCacheUseCase;

  @override
  AppState get initialState => InitialAppState();

  AppBloc({
    @required this.loginFromCacheUseCase,
  });

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppLoggedEvent) {
      yield AppLoggedState(event.user);
    }
    if (event is LoadLoginUserFromCacheEvent) {
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
