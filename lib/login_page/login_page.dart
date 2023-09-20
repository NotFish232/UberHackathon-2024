// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/login_page/bloc.dart';
import 'package:uber/main_page/bloc.dart';

// _LoginPageState class
class _LoginPageState extends State<LoginPage> {
  // Variables for the LoginPageBloc, form key, email, and password
  late final LoginPageBloc _bloc;
  late final GlobalKey<FormState> _formKey;
  late String? _email;
  late String? _password;

  // initState method
  @override
  void initState() {
    // Initializing the LoginPageBloc and form key
    _bloc = LoginPageBloc();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  // dispose method
  @override
  void dispose() {
    // Closing the LoginPageBloc
    _bloc.close();
    super.dispose();
  }

  // build method
  @override
  Widget build(BuildContext context) {
    // Returning a BlocBuilder
    return BlocBuilder(
        // Providing the LoginPageBloc
        bloc: _bloc,
        // Building the UI based on the LoginPageState
        builder: (_, LoginPageState state) {
          // Returning a Scaffold
          return Scaffold(
              body: Center(
            child: Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // TextFormField for email
                  SizedBox(
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'Email'),
                        onSaved: (newValue) => _email = newValue,
                      )),
                  // TextFormField for password
                  SizedBox(
                      width: 200,
                      child: TextFormField(
                          decoration:
                              const InputDecoration(hintText: 'Password'),
                          onSaved: (newValue) => _password = newValue)),
                  // Displaying error message if it exists
                  if (state.errorMessage != null)
                    SizedBox(
                        width: 200,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(state.errorMessage!.substring(state.errorMessage!.indexOf(']')+2)),
                          ),
                        )),
                  // Login button
                  ElevatedButton(
                    onPressed: () {
                      // Validating the form
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Submitting the form to the LoginPageBloc
                        _bloc
                            .submit(email: _email!, password: _password!)
                            .then((result) {
                          // If login is successful, update the MainPageBloc
                          if (result == true) {
                            context.read<MainPageBloc>().loggedIn();
                          }
                        });
                      }
                    },
                    child: const Text('Login!'),
                  ),
                  // Signup option
                  InkWell(
                      onTap: () =>
                          context.read<MainPageBloc>().redirectToSignup(),
                      child: const Text('Signup instead')),
                ])),
          ));
        });
  }
}

// LoginPage class
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // createState method
  @override
  State<LoginPage> createState() => _LoginPageState();
}
