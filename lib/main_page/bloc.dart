// Importing necessary packages
import 'package:flutter_bloc/flutter_bloc.dart';

// MainPageState class
class MainPageState {
  // Variables for signedIn and redirectToSignup
  final bool signedIn;
  final bool? redirectToSignup;

  // Constructor
  const MainPageState(this.signedIn, [this.redirectToSignup]);
}

// MainPageBloc class
class MainPageBloc extends Cubit<MainPageState> {
  // Constructor
  MainPageBloc() : super(const MainPageState(false, false));

  // Method to set the state as signed in
  void loggedIn() {
    emit(const MainPageState(true));
  }

  // Method to set the state as signed out
  void loggedOut() {
    emit(const MainPageState(false));
  }

  // Method to set the state to redirect to login
  void redirectToLogin() {
    emit(const MainPageState(false, false));
  }

  // Method to set the state to redirect to signup
  void redirectToSignup() {
    emit(const MainPageState(false, true));
  }
}
