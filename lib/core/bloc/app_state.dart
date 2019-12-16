import 'package:equatable/equatable.dart';
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
