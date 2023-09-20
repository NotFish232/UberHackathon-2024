// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/main_page/bloc.dart';
import 'package:uber/repositories/user_repository.dart';
import 'package:uber/signup_page/bloc.dart';

// State class for SignupPage
class _SignupPageState extends State<SignupPage> {
  // Declaring variables for SignupPageBloc, FormKey, email and password
  late final SignupPageBloc _bloc;
  late final GlobalKey<FormState> _formKey;
  late String? _email;
  late String? _password;

  // Initializing the state
  @override
  void initState() {
    // Initializing the SignupPageBloc and FormKey
    _bloc = SignupPageBloc();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  // Disposing the state
  @override
  void dispose() {
    // Closing the SignupPageBloc
    _bloc.close();
    super.dispose();
  }

  // Building the widget
  @override
  Widget build(BuildContext context) {
    // Using BlocBuilder to build the widget based on SignupPageState
    return BlocBuilder(
        bloc: _bloc,
        builder: (_, SignupPageState state) {
          // Returning a Scaffold widget
          return Scaffold(
              body: Center(
            child: Form(
                // Setting the key for the form
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // Text field for email input
                  SizedBox(
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'Email'),
                        onSaved: (newValue) => _email = newValue,
                      )),
                  // Text field for password input
                  SizedBox(
                      width: 200,
                      child: TextFormField(
                          decoration:
                              const InputDecoration(hintText: 'Password'),
                          onSaved: (newValue) => _password = newValue)),
                  // Displaying error message if any
                  if (state.errorMessage != null)
                    SizedBox(
                        width: 200,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(state.errorMessage!.substring(
                                state.errorMessage!.indexOf(']') + 2)),
                          ),
                        )),
                  // Signup button
                  ElevatedButton(
                    onPressed: () {
                      // Validating and saving the form
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Submitting the form
                        _bloc
                            .submit(email: _email!, password: _password!)
                            .then((result) {
                          // Creating a new user
                          FirebaseUserRepository().createUser();
                          // If signup is successful, logging in the user
                          if (result == true) {
                            context.read<MainPageBloc>().loggedIn();
                          }
                        });
                      }
                    },
                    child: const Text('Signup!'),
                  ),
                  // Link to login page
                  InkWell(
                      onTap: () =>
                          context.read<MainPageBloc>().redirectToLogin(),
                      child: const Text('Login instead')),
                ])),
          ));
        });
  }
}

// SignupPage widget which is a stateful widget
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  // Creating the state for this widget
  @override
  State<SignupPage> createState() => _SignupPageState();
}
