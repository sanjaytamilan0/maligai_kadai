import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/User/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  FirebaseAuth auth =FirebaseAuth.instance;


  // Future<void> oldLogIn(String email, String password, {String? phoneNumber}) async {
  //   emit(LoginLoading());
  //   try {
  //     if (phoneNumber == null) {
  //       // Email/password authentication
  //       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //       if (userCredential.user != null) {
  //         emit(const LoginSuccess(success: true));
  //       } else {
  //         emit(const LoginFailure('Invalid user details'));
  //         throw Exception('Authentication failed');
  //       }
  //     } else {
  //       // Phone OTP authentication
  //       await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: phoneNumber,
  //         verificationCompleted: (PhoneAuthCredential credential) async {
  //           // Automatically sign in user when verification is completed
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //           emit(const LoginSuccess(success: true));
  //         },
  //         verificationFailed: (FirebaseAuthException e) {
  //           emit(LoginFailure('Phone verification failed: ${e.message}'));
  //         },
  //         codeSent: (String verificationId, int? resendToken) async {
  //           // Save the verification ID and resend token for later use
  //           // You can store them in a state variable or pass them to another function
  //           // For simplicity, we're not doing anything with them here
  //         },
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           // Called when auto retrieval timeout occurs
  //           // You can handle it if needed, e.g., by asking the user to enter the code manually
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     emit(LoginFailure('Invalid user details'));
  //     print("Error logging in: $e");
  //     return Future.error("Failed to log in");
  //   }
  // }

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
