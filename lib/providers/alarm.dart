import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

class AlarmProvider extends ChangeNotifier {
  List<Alarm> _alarms = [
    Alarm(
        [true, true, true, true, true, true, true],
        "default",
        TimeOfDay(
            hour: TimeOfDay.now().hour + 2, minute: TimeOfDay.now().minute + 1),
        true)
  ];
  // 9andousty3zizty

  List<Alarm> get alarms => _alarms;

  set alarms(List<Alarm> alarms) {
    _alarms = alarms;
  }

  addAlarm(Alarm data) {
    _alarms.add(data);
    notifyListeners();
  }
}

class Alarm {
  final audioPlayerNotValidTime = AudioPlayer();
  final audioPlayerFireAlarme = AudioPlayer();

  void playErrorAudio() {
    audioPlayerNotValidTime!.play(AssetSource("audio/wrong.mp3"));
  }

  void playFinishAudio() {
    audioPlayerFireAlarme!.play(AssetSource("audio/play.mp3"));
  }

  final bool active;
  late Timer timer;
  final List<bool> repeat;
  final String name;
  final TimeOfDay time;
  Alarm(this.repeat, this.name, this.time, this.active);
  void activateTimer() {
    Duration d = Duration(hours: time.hour, minutes: time.minute);
    Duration nd =
        Duration(hours: TimeOfDay.now().hour, minutes: TimeOfDay.now().minute);

    timer = Timer(
      Duration(seconds: d.inSeconds - nd.inSeconds),
      () {
        playFinishAudio();
        print("alarm is Fired");
      },
    );
  }

  void cancelTimer() {
    print("timer is cancelled");
    timer.cancel();
  }
}
