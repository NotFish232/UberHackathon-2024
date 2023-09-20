// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:uber/account_page/bloc.dart';

// AccountPageState class
class _AccountPageState extends State<AccountPage> {
  // Variable to store the text input
  late String? _text;

  // GlobalKey for the form
  late final GlobalKey<FormState> _formKey;

  // AccountPageBloc instance
  late final AccountPageBloc _bloc;

  @override
  void initState() {
    // Initializing variables
    _bloc = AccountPageBloc();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // Closing the bloc
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                const Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Any Special Necessary Accommodations?',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    onSaved: (newValue) => _text = newValue,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _bloc.updateUser(_text!);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// AccountPage class
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}
