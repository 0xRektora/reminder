import 'package:firebase_auth/firebase_auth.dart';
import 'package:reminder/core/data/user.dart';

class UserModel extends User {
  UserModel(
    String uid,
    String name, {
    String creationDate,
  }) : super(uid, name);

  factory UserModel.fromFirebaseUser(
    FirebaseUser firebaseUser, {
    String creationDate,
  }) {
    return UserModel(
      firebaseUser.uid,
      firebaseUser.displayName,
      creationDate: creationDate,
    );
  }
}
