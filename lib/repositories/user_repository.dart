// Importing necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/models/user_model.dart';

// Sealed UserRepository class
sealed class UserRepository {
  // Constructor
  const UserRepository();

  // Method to create a user
  Future<void> createUser();
  // Method to update a user
  Future<void> updateUser(UserModel user);
}

// FirebaseUserRepository class that extends UserRepository
class FirebaseUserRepository extends UserRepository {
  // Declaring variables for FirebaseFirestore, CollectionReference, and FirebaseAuth
  late final FirebaseFirestore _database;
  late final CollectionReference _collection;
  late final FirebaseAuth _auth;

  // Constructor
  FirebaseUserRepository() {
    // Initializing FirebaseFirestore, CollectionReference, and FirebaseAuth
    _database = FirebaseFirestore.instance;
    _collection = _database.collection('/users');
    _auth = FirebaseAuth.instance;
  }

  // Overriding createUser method
  @override
  Future<void> createUser() async {
    // Creating a new UserModel
    UserModel user = UserModel();
    // Adding the user to the collection
    await _collection.doc(_auth.currentUser!.uid).set(user.toJson());
  }

  // Overriding updateUser method
  @override
  Future<void> updateUser(UserModel user) async {
    // Updating the user in the collection
    await _collection.doc(_auth.currentUser!.uid).update(user.toJson());
  }
}
