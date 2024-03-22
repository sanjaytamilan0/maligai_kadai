
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool success;

  const LoginSuccess({required this.success});

  @override
  List<Object?> get props => [success];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

