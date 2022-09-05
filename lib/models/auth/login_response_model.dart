import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.token,
    required this.idUser,
  });
  late final String? message;
  late final String? token;
  late final String? idUser;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    idUser = json['idUser'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['idUser'] = idUser;
    _data['token'] = token;
    return _data;
  }
}
