// UserModel class
final class UserModel {
  // Declaring variables for id and disabilities
  late final String? id;
  late final String? disabilities;

  // Constructor
  UserModel({this.disabilities, this.id});

  // Constructor from JSON
  UserModel.fromJson(dynamic json) {
    // If the JSON is well-formed
    if (json case {'id': String id, 'disabilities': String disabilities}) {
      // Setting the id and disabilities
      this.id = id;
      this.disabilities = disabilities;
    } 
    // If the JSON is not well-formed
    else {
      throw ArgumentError('Malformed json: $json');
    }
  }

  // Method to copy the UserModel
  UserModel copyWith({String? id, String? disabilities}) {
    // Returning a new UserModel with the provided id and disabilities, or the existing ones if not provided
    return UserModel(
        id: id ?? this.id, disabilities: disabilities ?? this.disabilities);
  }

  // Method to convert the UserModel to JSON
  Map<String, Object?> toJson() {
    // Returning a map with the disabilities
    return {'disabilities': disabilities};
  }
}
