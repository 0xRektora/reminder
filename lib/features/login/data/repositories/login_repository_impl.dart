import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/data/user.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/core/error/failures.dart';
import 'package:reminder/core/static/c_s_shared_prefs.dart';
import 'package:reminder/features/login/data/datasources/login_data_source.dart';
import 'package:reminder/features/login/domain/repositories/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      final bool userExist = await loginDataSource.userExist(uid: user.uid);

      if (!userExist) {
        final DateTime now = DateTime.now();

        final String today = "${now.year}-${now.month}-${now.day}";

        final Map<String, dynamic> data = {
          'creationDate': today,
        };

        await loginDataSource.creationDate(
          uid: user.uid,
          data: data,
        );
      }

      return Right(user);
    } on ServerException catch (e) {
      print('ServerException LoginRepositoryImpl:' + e.message);
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      print('Exception LoginRepositoryImpl:' + e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginFromCache(FirebaseAuth _auth) async {
    try {
      final user = await loginDataSource.loginFromCache(_auth);
      final sh = await SharedPreferences.getInstance();
      sh.setBool(CSSharedPrefs.FROM_CACHE, true);
      return right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
