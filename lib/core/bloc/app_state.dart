import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/data/user.dart';

abstract class AppState extends Equatable {
  const AppState();
  @override
  List<Object> get props => null;
}

class InitialAppState extends AppState {}

class AppLoggedState extends AppState {
  final User user;

  AppLoggedState(this.user);
}

class LoadedLoginFromCacheState extends AppState {
  final User user;

  LoadedLoginFromCacheState({@required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorAppState extends AppState {
  final String message;

  ErrorAppState({@required this.message});
  @override
  List<Object> get props => [message];
}
