import 'package:equatable/equatable.dart';
import 'package:reminder/core/data/user.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AppLoggedEvent extends AppEvent {
  final User user;

  AppLoggedEvent(this.user);
  @override
  List<Object> get props => [user];
}

class CAppLoadLoginUserFromCacheEvent extends AppEvent {}

class AppDisconnectEvent extends AppEvent {}
