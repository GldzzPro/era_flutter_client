import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_login_register_nodejs/models/auth/login_response_model.dart';
import 'package:flutter_login_register_nodejs/models/notes/update_note_request.dart';
import 'package:flutter_login_register_nodejs/pages/home-pages/home/notes_views/curved_box.dart';
import 'package:flutter_login_register_nodejs/services/shared_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../../../configs/config.dart';
import '../../../../models/notes/add_note_request.dart';
import '../../../../services/api_service.dart';
import 'home_view.dart';

class Edit extends StatefulWidget {
  bool? editable;
  String? title;
  String? content;
  String? id;
  Edit({Key? key, this.editable, this.title, this.content, this.id})
      : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  bool isApiCallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? title;
  String? content;
  @override
  Widget build(BuildContext context) {
    title = widget.title;
    content = widget.content;
    return Scaffold(
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: _editUI(context),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

  Widget _editUI(BuildContext context) {
    LoginResponseModel? loginDetails;
    void getDetails() async {
      loginDetails = await SharedService.loginDetails();
    }

    getDetails();
    print(title);
    print(content);
    print("mia san mia ${widget.editable}");
    Color color = Theme.of(context).backgroundColor;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "NEW NOTE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: CurvedBox(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FormHelper.inputFieldWidget(
                  context,
                  const Icon(Icons.edit),
                  "title",
                  "title",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'title can\'t be empty.';
                    }

                    return null;
                  },
                  (onSavedVal) => {
                    title = onSavedVal,
                  },
                  initialValue: title ?? "",
                  obscureText: false,
                  borderColor: Colors.transparent,
                  borderFocusColor: Colors.transparent,
                  prefixIconColor: Colors.white,
                  textColor: Colors.white,
                  hintColor: Colors.white.withOpacity(0.7),
                  borderRadius: 10,
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: CurvedBox(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FormHelper.inputFieldWidget(
                  context,
                  const Icon(Icons.edit),
                  "content",
                  "content",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'content can\'t be empty.';
                    }

                    return null;
                  },
                  (onSavedVal) => {
                    content = onSavedVal,
                  },
                  initialValue: content ?? "",
                  isMultiline: true,
                  borderColor: Colors.transparent,
                  borderFocusColor: Colors.transparent,
                  prefixIconColor: Colors.white,
                  textColor: Colors.white,
                  hintColor: Colors.white.withOpacity(0.7),
                  borderRadius: 10,
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormHelper.submitButton(
                  widget.editable == null
                      ? "ADD NEW NOTE"
                      : "update note changes ",
                  () {
                    if (validateAndSave()) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      if (widget.editable == null) {
                        AddNoteRequestModel model = AddNoteRequestModel(
                          idUser: loginDetails!.idUser!,
                          title: title!,
                          note: content!,
                          importance: "important",
                        );

                        APIService.addNote(model).then(
                          (response) {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (response.message != null) {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "note created succefully ",
                                "OK",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            } else {}
                          },
                        );
                      } else {
                        UpdateNoteRequest model = UpdateNoteRequest(
                          id: widget.id!,
                          idUser: loginDetails!.idUser!,
                          title: title!,
                          note: content!,
                          importance: "important",
                        );

                        APIService.updateNote(model).then(
                          (response) {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (response.message != null) {
                              print(response.message);
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "note updated succefully ",
                                "OK",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            } else {}
                          },
                        );
                      }
                    }
                  },
                  width: 300,
                  btnColor: color,
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ));
                  },
                  child: Text(
                    'return to notes',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ]),
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
