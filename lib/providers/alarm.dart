import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AlarmProvider extends ChangeNotifier {
  String _errorMessage = '';
  List<Alarm> _alarms = [];

  List<Alarm> get alarms => _alarms;

  set alarms(List<Alarm> alarms) {
    _alarms = alarms;
  }

  String get errorMessage => _errorMessage;

  addAlarm(Alarm data) {
    _alarms.add(data);
    notifyListeners();
  }
}

class Alarm {
  final List<bool> repeat;
  final String name;
  final TimeOfDay time;
  Alarm(this.repeat, this.name, this.time);
}
