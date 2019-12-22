import 'package:meta/meta.dart';

class ServerException implements Exception {
  final String message;

  ServerException({@required this.message}) : super();
}

class InternalException implements Exception {
  final String message;

  InternalException({@required this.message}) : super();
}
