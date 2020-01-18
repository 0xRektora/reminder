import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/data/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/login_repository.dart';

class LoginWithGoogle implements Usecase<User, NoParams> {
  final LoginRepository loginRepository;

  LoginWithGoogle(this.loginRepository);

  @override
  Future<Either<Failure, User>> call(NoParams noParams) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return await loginRepository.loginWithGoogle(_googleSignIn, _auth);
  }
}
