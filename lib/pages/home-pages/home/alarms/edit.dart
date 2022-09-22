import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_login_register_nodejs/models/auth/login_response_model.dart';
import 'package:flutter_login_register_nodejs/models/notes/update_note_request.dart';
import 'package:flutter_login_register_nodejs/pages/home-pages/home/alarms/allview.dart';
import 'package:flutter_login_register_nodejs/pages/home-pages/home/notes_views/curved_box.dart';
import 'package:flutter_login_register_nodejs/services/shared_service.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../../../configs/config.dart';
import '../../../../models/notes/add_note_request.dart';
import '../../../../providers/alarm.dart';
import '../../../../services/api_service.dart';

class EditAlarm extends StatefulWidget {
  bool? editable;
  String? title;
  String? content;
  String? id;
  bool alarmTimeIsSeted;
  EditAlarm(
      {Key? key,
      this.alarmTimeIsSeted = false,
      this.editable,
      this.title,
      this.content,
      this.id})
      : super(key: key);

  @override
  State<EditAlarm> createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm> {
  AlarmProvider get state => Provider.of(context, listen: false);
  final List<bool> _values = [true, false, true, false, false, true, false];

  bool isApiCallProcess = false;
  TimeOfDay _time = TimeOfDay.now();

  AudioPlayer? audioPlayerNotValidTime;
  AudioPlayer? audioPlayerFireAlarme;

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        widget.alarmTimeIsSeted = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    audioPlayerNotValidTime = AudioPlayer();
    audioPlayerFireAlarme = AudioPlayer();
  }

  void playErrorAudio() {
    audioPlayerNotValidTime!.play(AssetSource("audio/wrong.mp3"));
  }

  void playFinishAudio() {
    audioPlayerFireAlarme!.play(AssetSource("audio/play.mp3"));
  }

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? title;
  String? content;
  @override
  Widget build(BuildContext context) {
    print("building");
    print(widget.alarmTimeIsSeted);
    if (widget.alarmTimeIsSeted) {
      TimeOfDay nowTime = TimeOfDay.now();

      Duration d = Duration(hours: _time.hour, minutes: _time.minute);
      Duration nd = Duration(hours: nowTime.hour, minutes: nowTime.minute);

      if (d > nd) {
        print("you selected a valid time ");
        // FormHelper.showSimpleAlertDialog(
        //   context,
        //   Config.appName,
        //   "you selected a valid time  thank you but not kante version",
        //   "OK",
        //   () {
        //     Navigator.of(context).pop();
        //   },
        // );
        print("remaing ${d.inSeconds - nd.inSeconds}");
      } else {
        playErrorAudio();
        print(
            "you selected a non valid time your time is already passed wanna return to the past or what this is not possible");
        // FormHelper.showSimpleAlertDialog(
        //   context,
        //   Config.appName,
        //   "you selected a non valid time your time is already passed wanna return to the past or what this is not possible",
        //   "OK",
        //   () {
        //     Navigator.of(context).pop();
        //   },
        // );
      }
      print(d.inSeconds);
    }
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

    List<String> days = [
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday",
      "saturday",
      "sunday"
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "NEW ALARM",
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
                child: ElevatedButton(
                  onPressed: _selectTime,
                  child: Text('SELECT TIME FOR YOUR NEXT ALARM'),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Next Alarm In Time: ${_time.format(context)}',
              ),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: <Widget>[
              for (int i = 0; i < days.length; i++)
                ListTile(
                  title: Text(
                    'repeat on ${days[i]}',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color:
                            i == days.length ? Colors.black38 : Colors.black),
                  ),
                  leading: Switch(
                    value: _values[i],
                    activeColor: Color(0xFF6200EE),
                    onChanged: i == days.length
                        ? null
                        : (bool value) {
                            setState(() {
                              _values[i] = value;
                            });
                          },
                  ),
                ),
            ],
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormHelper.submitButton(
                  widget.editable == null
                      ? "ADD NEW ALARM"
                      : "update alarm changes ",
                  () {
                    if (validateAndSave()) {
                      // setState(() {
                      //   isApiCallProcess = true;
                      // });
                      if (widget.editable != null) {
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
                        // setState(() {
                        //   isApiCallProcess = false;
                        // });
                        print("add succefully new alarm");
                        state.addAlarm(Alarm(_values, title!, _time, true));

                        // UpdateNoteRequest model = UpdateNoteRequest(
                        //   id: widget.id!,
                        //   idUser: loginDetails!.idUser!,
                        //   title: title!,
                        //   note: content!,
                        //   importance: "important",
                        // );

                        // APIService.updateNote(model).then(
                        //   (response) {
                        //     setState(() {
                        //       isApiCallProcess = false;
                        //     });

                        //     if (response.message != null) {
                        //       print(response.message);
                        //       FormHelper.showSimpleAlertDialog(
                        //         context,
                        //         Config.appName,
                        //         "note updated succefully ",
                        //         "OK",
                        //         () {
                        //           Navigator.of(context).pop();
                        //         },
                        //       );
                        //     } else {}
                        //   },
                        // );
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
                      builder: (context) => AlarmAllView(),
                    ));
                  },
                  child: Text(
                    'return to alarms',
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
