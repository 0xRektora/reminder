import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final FirebaseUser firebaseUser;

  User({
    @required this.firebaseUser,
  });

  @override
  List<Object> get props => [firebaseUser];
}
