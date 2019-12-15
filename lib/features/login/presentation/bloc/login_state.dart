import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/data/user.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoadedLoginState extends LoginState {
  final User user;

  LoadedLoginState({@required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorLoginState extends LoginState {
  final String message;

  ErrorLoginState({@required this.message});

  @override
  List<Object> get props => [message];
}
