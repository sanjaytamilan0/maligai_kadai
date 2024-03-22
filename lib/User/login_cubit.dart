import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/User/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  FirebaseAuth auth =FirebaseAuth.instance;

  Future<void> oldLogIn(String email, String password) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        emit(const LoginSuccess( success: true));
      } else {
        emit(const LoginFailure('invalid user details'));
        throw Exception('Authentication failed');
      }
    } catch (e) {
      emit(LoginFailure('invalid user details'));
      print("Error logging in: $e");
      return Future.error("Failed to log in");
    }
  }
}
