import 'package:get_it/get_it.dart';
import 'package:reminder/features/login/data/repositories/login_repository_impl.dart';
import 'package:reminder/features/login/domain/usecases/login_with_google.dart';
import 'package:reminder/features/login/presentation/bloc/bloc.dart';

import 'features/login/data/datasources/login_data_source.dart';
import 'features/login/domain/repositories/login_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Feature login
  fLogin();
}

Future<void> fLogin() async {
  // Bloc
  sl.registerFactory(
    () => LoginBloc(
      loginWithGoogle: sl(),
    ),
  );

  //Usecase
  sl.registerLazySingleton(() => LoginWithGoogle(sl()));

  //Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginDataSource: sl()));

  //Datasources
  sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImpl());
}
