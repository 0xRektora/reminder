import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({this.message});

  @override
  List<Object> get props => null;
}

class ServerFailure extends Failure {
  ServerFailure({String message}) : super(message: message);
}
