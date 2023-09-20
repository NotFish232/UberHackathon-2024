// Importing necessary packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/models/user_model.dart';
import 'package:uber/repositories/user_repository.dart';

// AccountPageState class
class AccountPageState {
  // Constructor
  const AccountPageState();
}

// AccountPageBloc class
class AccountPageBloc extends Cubit<AccountPageState> {
  // Constructor
  AccountPageBloc() : super(const AccountPageState());

  // Method to update the user
  Future<void> updateUser(String disabilities) async {
    // Creating a new UserModel with the updated disabilities
    UserModel user = UserModel(disabilities: disabilities);

    // Updating the user in the FirebaseUserRepository
    FirebaseUserRepository().updateUser(user);
  }
}
