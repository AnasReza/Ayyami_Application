import 'package:flutter/material.dart';

class LikoriaTimerProvider extends ChangeNotifier {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  bool isTimerStart = false;

  int get getSec => seconds;

  int get getmin => minutes;
  int get getHours => hours;
  int get getDays => days;

  bool get getTimerStart => isTimerStart;

  setSec(int value) {
    seconds = value;
    notifyListeners();
  }

  setMin(int value) {
    minutes = value;
    notifyListeners();
  }
  setHours(int value){
    hours=value;
    notifyListeners();
  }
  setDays(int value){
    days=value;
    notifyListeners();
  }

  setTimerStart(bool value) {
    isTimerStart = value;
    notifyListeners();
  }
}
