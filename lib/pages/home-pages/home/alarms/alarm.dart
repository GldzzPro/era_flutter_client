import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../../configs/config.dart';

class Milan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Picker Themed Demo',
      debugShowCheckedModeBanner: false,
      theme: _buildShrineTheme(),
      home: Time(),
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

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    toggleableActiveColor: shrinePink400,
    accentColor: shrineBrown900,
    primaryColor: shrinePink100,
    buttonColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textSelectionColor: shrinePink100,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink400,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
