import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../../configs/config.dart';

class Milan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Time(),
    );
  }
}

class Time extends StatefulWidget {
  bool alarmTimeIsSeted;
  bool alarmDateIsSeted;
  Time({Key? key, this.alarmTimeIsSeted = false, this.alarmDateIsSeted = false})
      : super(key: key);
  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  TimeOfDay _time = TimeOfDay.now();
  DateTime _date = DateTime.now();
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

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
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

  void stopErrorAudio() {
    audioPlayerNotValidTime?.stop();
  }

  void playFinishAudio() {
    audioPlayerFireAlarme!.play(AssetSource("audio/play.mp3"));
  }

  void stopFinishAudio() {
    audioPlayerFireAlarme?.stop();
  }

  // dismiss the animation when widgit exits screen

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
        Timer(
          Duration(seconds: d.inSeconds - nd.inSeconds),
          () {
            playFinishAudio();
            print("alarm is Fired");
          },
        );
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectTime,
              child: Text('SELECT TIME FOR YOUR NEXT ALARM'),
            ),
            SizedBox(height: 8),
            Text(
              'Next Alarm In Time: ${_time.format(context)}',
            ),
            ElevatedButton(
              onPressed: _selectDate,
              child: Text('SELECT DATE'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected date: ${_date.subtract(Duration(days: 5))}',
            ),
          ],
        ),
      ),
    );
  }
}
