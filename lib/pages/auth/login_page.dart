import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/configs/app_colors.dart';
import 'package:flutter_login_register_nodejs/providers/profile.dart';
import 'package:flutter_login_register_nodejs/services/shared_service.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../services/api_service.dart';
import '../../configs/config.dart';
import '../../models/auth/login_request_model.dart';
import '../home-pages/home/notes_views/curved_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ProfileProvider get state => Provider.of(context, listen: false);
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
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
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 0),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              width: size.width * 0.9,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.email),
                "email",
                "email",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return 'email can\'t be empty.';
                  }

                  return null;
                },
                (onSavedVal) => {
                  email = onSavedVal,
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
                    return 'Password can\'t be empty.';
                  }

                  return null;
                },
                (onSavedVal) => {
                  password = onSavedVal,
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
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Forget Password ?',
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  LoginRequestModel model = LoginRequestModel(
                    email: email,
                    password: password,
                  );

                  APIService.login(model).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        SharedService.profileDetails()
                            .then((value) => state.setProfileData(value!));

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      } else {
                        print(response);
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Invalid email/Password !!",
                          "OK",
                          () {
                            Navigator.of(context).pop();
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
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Dont have an account ? ',
                    ),
                    TextSpan(
                      text: '  Sign up',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            '/register',
                          );
                        },
                    ),
                  ],
                ),
              ),
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
