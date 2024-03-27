
// RegistrationState
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {

}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final UserCredential userCredential;

  RegistrationSuccess(this.userCredential);
}

class RegistrationFailure extends RegistrationState {
  final String errorMessage;

  RegistrationFailure(this.errorMessage);
}


