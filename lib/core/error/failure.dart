import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object> get props => [];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure() : super(message: 'Unexpected Error');
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message: message);
}

class LocalFailure extends Failure {}
