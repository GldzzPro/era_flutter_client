import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/models/auth/login_request_model.dart';
import 'package:flutter_login_register_nodejs/models/auth/register_request_model.dart';
import 'package:flutter_login_register_nodejs/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../configs/app_colors.dart';
import '../../configs/config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? name;
  String? lastName;
  String? password;
  String? email;
  String? age;
  String? phone;

  @override
  void initState() {
    super.initState();
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        backgroundColor: AppColors.scaffoldBackground,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    Color color = Theme.of(context).backgroundColor;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.scaffoldBackground,
                  AppColors.scaffoldBackground,
                ],
              ),
              borderRadius: BorderRadius.only(
                //topLeft: Radius.circular(100),
                //topRight: Radius.circular(150),
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              width: size.width * 0.9,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.person),
                "name",
                "name",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    print(onValidateVal.toString());
                    return 'name can\'t be empty.';
                  }

                  return null;
                },
                (onSavedVal) => {
                  name = onSavedVal,
                },
                initialValue: "",
                obscureText: false,
                borderFocusColor: Colors.transparent,
                prefixIconColor: Colors.white,
                borderColor: Colors.transparent,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
              ),
            ),
          ]),
          Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              width: size.width * 0.9,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.person),
                "lastName",
                "lastName",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    print(onValidateVal.toString());
                    return 'lastName can\'t be empty.';
                  }

                  return null;
                },
                (onSavedVal) => {
                  lastName = onSavedVal,
                },
                initialValue: "",
                obscureText: false,
                borderFocusColor: Colors.transparent,
                prefixIconColor: Colors.white,
                borderColor: Colors.transparent,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
              ),
            ),
          ]),
          Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              width: size.width * 0.9,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.mail),
                "Email",
                "Email",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return 'Email can\'t be empty.';
                  }

                  return null;
                },
                (onSavedVal) => {
                  email = onSavedVal,
                },
                initialValue: "",
                borderFocusColor: Colors.transparent,
                prefixIconColor: Colors.white,
                borderColor: Colors.transparent,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
              ),
            ),
          ]),
          Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              width: size.width * 0.9,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.calendar_month),
                "age",
                "age",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    print(onValidateVal.toString());
                    return 'age can\'t be empty.';
                  } else {
                    if (!isNumeric(age!)) {
                      return 'age must be a number.';
                    }
                  }

                  return null;
                },
                (onSavedVal) => {
                  age = onSavedVal,
                },
                onChange: (text) {
                  print(text);
                  age = text;
                },
                initialValue: "",
                obscureText: false,
                borderFocusColor: Colors.transparent,
                prefixIconColor: Colors.white,
                borderColor: Colors.transparent,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
              ),
            ),
          ]),
          Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              width: size.width * 0.9,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.phone),
                "phone",
                "phone",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    print(onValidateVal.toString());
                    return 'phone can\'t be empty.';
                  } else {
                    if (!isNumeric(phone!)) {
                      return 'phone must be a number.';
                    }
                  }

                  return null;
                },
                (onSavedVal) => {
                  phone = onSavedVal,
                },
                onChange: (text) {
                  print(text);
                  phone = text;
                },
                initialValue: "",
                obscureText: false,
                borderFocusColor: Colors.transparent,
                prefixIconColor: Colors.white,
                borderColor: Colors.transparent,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
              ),
            ),
          ]),
          Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              width: size.width * 0.9,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.lock),
                "Password",
                "Password",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    print(onValidateVal.toString());
                    return 'password can\'t be empty.';
                  }

                  return null;
                },
                (onSavedVal) => {
                  password = onSavedVal,
                },
                onChange: (text) {
                  print(text);
                  password = text;
                },
                initialValue: "",
                obscureText: hidePassword,
                borderFocusColor: Colors.transparent,
                prefixIconColor: Colors.white,
                borderColor: Colors.transparent,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  color: Colors.white.withOpacity(0.7),
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  RegisterRequestModel model = RegisterRequestModel(
                    name: name,
                    lastName: lastName,
                    password: password,
                    email: email,
                    age: num.tryParse(age!),
                    phone: phone,
                  );

                  APIService.register(model).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response.message != null) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Registration Successful. Please login to the account",
                          "OK",
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                              (route) => false,
                            );
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: AppColors.buttonColor,
              borderColor: Colors.transparent,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
