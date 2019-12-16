import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder/core/usecases/usecase.dart';

import '../../../../core/data/user.dart';
import '../../../../core/error/failures.dart';
import '../repositories/login_repository.dart';

class LoginFromCacheUseCase implements Usecase<User, NoParams> {
  final LoginRepository loginRepository;

  LoginFromCacheUseCase(this.loginRepository);

  @override
  Future<Either<Failure, User>> call(NoParams noParams) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return await loginRepository.loginFromCache(_auth);
  }
}
