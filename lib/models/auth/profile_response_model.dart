import 'dart:convert';

ProfileResponseModel profileResponseJson(String str) =>
    ProfileResponseModel.fromJson(json.decode(str));

class ProfileResponseModel {
  ProfileResponseModel({
    required this.message,
    required this.user,
  });
  late final String message;
  late final Data user;

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = Data.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['user'] = user.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.name,
    required this.email,
    required this.lastName,
    required this.password,
    required this.phone,
    required this.age,
  });
  late final String name;
  late final String email;
  late final String lastName;
  late final String password;
  late final String phone;
  late final num age;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    lastName = json['lastName'];
    password = json['password'];
    phone = json['phone'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['lastName'] = lastName;
    _data['password'] = password;
    _data['phone'] = phone;
    _data['age'] = age;
    return _data;
  }
}
