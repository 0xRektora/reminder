import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/data/user.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/core/error/failures.dart';
import 'package:reminder/features/login/data/datasources/login_data_source.dart';
import 'package:reminder/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  // Return the FirebaseUser
  final LoginDataSource loginDataSource;

  LoginRepositoryImpl({
    @required this.loginDataSource,
  });

  @override
  Future<Either<Failure, User>> loginWithGoogle(
      GoogleSignIn _googleSignIn, FirebaseAuth _auth) async {
    try {
      final user = await loginDataSource.loginWithGoogle(_googleSignIn, _auth);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> loginFromCache(FirebaseAuth _auth) async {
    try {
      final user = await loginDataSource.loginFromCache(_auth);
      return right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
