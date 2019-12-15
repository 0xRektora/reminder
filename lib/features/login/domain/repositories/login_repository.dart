import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/data/user.dart';
import '../../../../core/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> loginWithGoogle(
      GoogleSignIn _googleSignIn, FirebaseAuth _auth);
}
