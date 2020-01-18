import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder/core/error/exceptions.dart';
import 'package:reminder/core/static/c_s_db_routes.dart';
import 'package:reminder/features/login/data/models/login_model.dart';

abstract class LoginDataSource {
  Future<UserModel> loginWithGoogle(
      GoogleSignIn _googleSignIn, FirebaseAuth _auth);
  Future<UserModel> loginFromCache(FirebaseAuth _auth);

  Future<bool> userExist({
    String uid,
  });
  Future<void> creationDate({
    String uid,
    Map<String, dynamic> data,
  });
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
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> loginFromCache(FirebaseAuth _auth) async {
    try {
      final user = await _auth.currentUser();
      if (user == null) {
        throw Exception("User cache null");
      }
      return UserModel.fromFirebaseUser(user);
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> creationDate({
    String uid,
    Map<String, dynamic> data,
  }) async {
    try {
      await Firestore.instance
          .collection(CSDbRoutes.PRESCRIPTIONS)
          .document(uid)
          .setData(
            data,
            merge: true,
          );
    } on Exception catch (e) {
      print(
        'ERROR feature/login/datasource/LoginDataSourceImpl: ' + e.toString(),
      );
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> userExist({
    String uid,
  }) async {
    try {
      final result = await Firestore.instance
          .collection(CSDbRoutes.PRESCRIPTIONS)
          .document(uid)
          .get();

      if (result.data == null) {
        return false;
      } else {
        return true;
      }
    } on Exception catch (e) {
      print(
        'ERROR feature/login/datasource/LoginDataSourceImpl: ' + e.toString(),
      );
      throw ServerException(message: e.toString());
    }
  }
}
