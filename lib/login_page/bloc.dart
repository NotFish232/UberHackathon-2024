// Importing necessary packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

// LoginPageState class
class LoginPageState {
  // Variable for errorMessage
  final String? errorMessage;

  // Constructor
  const LoginPageState([this.errorMessage]);
}

// LoginPageBloc class
class LoginPageBloc extends Cubit<LoginPageState> {
  // Constructor
  LoginPageBloc() : super(const LoginPageState());

  // Method to submit the login form
  Future<bool> submit({required String email, required String password}) async {
    try {
      // Signing in with email and password using FirebaseAuth
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      // Emitting LoginPageState with the error message
      emit(LoginPageState('$e'));
      return false;
    }
  }
}
