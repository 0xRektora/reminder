import 'package:get_it/get_it.dart';
import 'package:reminder/core/bloc/app_bloc.dart';
import 'package:reminder/features/login/data/repositories/login_repository_impl.dart';
import 'package:reminder/features/login/domain/usecases/login_from_cache.dart';
import 'package:reminder/features/login/domain/usecases/login_with_google.dart';
import 'package:reminder/features/login/presentation/bloc/bloc.dart';

import 'features/login/data/datasources/login_data_source.dart';
import 'features/login/domain/repositories/login_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  cApp();
  //Feature login
  fLogin();
}

Future<void> cApp() async {
  // Bloc
  sl.registerFactory(() => AppBloc());
}

Future<void> fLogin() async {
  // Bloc
  sl.registerFactory(
    () => LoginBloc(
      loginWithGoogle: sl(),
      loginFromCacheUseCase: sl(),
    ),
  );

  //Usecase
  sl.registerLazySingleton(() => LoginWithGoogle(sl()));
  sl.registerLazySingleton(() => LoginFromCacheUseCase(sl()));

  //Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginDataSource: sl()));

  //Datasources
  sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImpl());
}
