import 'package:firebase_auth/firebase_auth.dart';
import 'package:reminder/core/data/user.dart';

class UserModel extends User {
  UserModel(String uid, String name) : super(uid, name);

  factory UserModel.fromFirebaseUser(FirebaseUser firebaseUser) {
    return UserModel(firebaseUser.uid, firebaseUser.displayName);
  }
}
