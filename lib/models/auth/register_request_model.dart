class RegisterRequestModel {
  RegisterRequestModel(
      {this.name,
      this.lastName,
      this.password,
      this.email,
      this.age,
      this.phone});
  late final String? name;
  late final String? lastName;
  late final String? password;
  late final String? email;
  late final num? age;
  late final String? phone;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    password = json['password'];
    email = json['email'];
    age = json['age'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['lastName'] = lastName;
    _data['password'] = password;
    _data['email'] = email;
    _data['age'] = age;
    _data['phone'] = phone;

    return _data;
  }
}

// // {
// //       "name": false,
// //       "lastName": false,
// //       "age": false,
// //       "phone": false,
// //       "email": false,
// //       "password": false,
// //     }
    