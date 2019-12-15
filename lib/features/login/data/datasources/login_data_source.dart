import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/features/login/data/models/login_model.dart';

abstract class LoginDataSource {
  Future<UserModel> loginWithGoogle(
      GoogleSignIn _googleSignIn, FirebaseAuth _auth);
}

class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<UserModel> loginWithGoogle(
      GoogleSignIn _googleSignIn, FirebaseAuth _auth) async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;

      return UserModel.fromFirebaseUser(user);
    } on Exception catch (e) {
      print("ERROR feature/login/datasource/LoginDataSourceImpl: " +
          e.toString());
      throw ServerException();
    }
  }
}
