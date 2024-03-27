import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("Sign-out successful");
      emit(LogoutSuccess());
    } catch (e) {
      print("Error signing out: $e");
      emit(LogoutFailure("Error signing out: $e"));
    }
  }
}
