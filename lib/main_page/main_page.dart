// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/home_page/home_page.dart';
import 'package:uber/login_page/login_page.dart';
import 'package:uber/main_page/bloc.dart';
import 'package:uber/signup_page/signup_page.dart';

// MainPage widget which is a stateless widget
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // Building the widget
  @override
  Widget build(BuildContext context) {
    // Returning a BlocBuilder
    return BlocBuilder(
        // Providing the MainPageBloc
        bloc: context.read<MainPageBloc>(),
        // Building the UI based on the MainPageState
        builder: (_, MainPageState state) {
          // If the user is signed in, return HomePage
          if (state.signedIn) {
            return const HomePage();
          }
          // If redirectToSignup is true, return SignupPage
          if (state.redirectToSignup!) {
            return const SignupPage();
          }
          // Otherwise, return LoginPage
          return const LoginPage();
        });
  }
}
