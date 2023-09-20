
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPageState {
  final String? errorMessage;
  const SignupPageState([this.errorMessage]);
}

class SignupPageBloc extends Cubit<SignupPageState> {
  SignupPageBloc() : super(const SignupPageState());

  // return whether it was successfull, then dispaly statement
  //if not, otherwise continue to homepage
  Future<bool> submit({required String email, required String password}) async {
    try{
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    }

    on FirebaseAuthException catch(e){
      emit(SignupPageState('$e'));
      return false;
    }

  }
}
