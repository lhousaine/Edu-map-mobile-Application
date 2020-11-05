import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

// General failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InvalidJsonFailure extends Failure {
  @override
  List<Object> get props => [];
}

class EncryptionFailure extends Failure {
  @override
  List<Object> get props => null;
}

class NetworkFailure extends Failure {
  @override
  List<Object> get props => [];
}