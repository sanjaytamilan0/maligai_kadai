part of 'log_out_cubit.dart';

@immutable
abstract class LogOutState {}

class LogOutInitial extends LogOutState {}
class LogoutSuccess extends LogOutState {}

class LogoutFailure extends LogOutState{
  final String error;

  LogoutFailure(this.error);
}
