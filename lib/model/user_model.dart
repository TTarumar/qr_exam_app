class UserModel {
  String email;
  String name;
  String surname;

  UserModel(
      {this.name,
        this.email,
        this.surname});

  Map<String, dynamic> toMap() {
    return {
      'username': email,
      'name': name,
      'surname': surname,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : email = map['email'],
        name = map['name'],
        surname = map['surname'];

  @override
  String toString() {
    return 'UserModel{email: $email\nname: $name\n surname:$surname';
  }
}