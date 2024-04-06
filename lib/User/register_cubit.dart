import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/User/register_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());
  FirebaseAuth auth =FirebaseAuth.instance;
  bool isObscure = true;





  Future<void> registerNew(String email, String password) async {
    print('_______________________________');
    try {
      emit(RegistrationLoading());
      UserCredential? credential =
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      print(credential);
      if (credential.user != null) {
        emit(RegistrationSuccess(credential));
        print(credential);
      } else {
        // Handle the case where createUserWithEmailAndPassword returns null
        emit(RegistrationFailure('Registration failed: Unexpected null value'));
      }
    } catch (e) {
      emit(RegistrationFailure('Registration failed: $e'));
    }
  }


}
