import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class InternalFailure extends Failure {
  InternalFailure({String message}) : super(message: message);
  @override
  List<Object> get props => [message];
}
