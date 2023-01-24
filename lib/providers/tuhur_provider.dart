import 'package:flutter/cupertino.dart';

class TuhurProvider extends ChangeNotifier{
  int from=-1;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  bool isTimerStart = false;
  String tuhurID='';

  int get getSec => seconds;

  int get getmin => minutes;
  int get getHours => hours;
  int get getDays => days;
  int get getFrom => from;

  bool get getTimerStart => isTimerStart;
  String get getTuhurID => tuhurID;

  setTuhurID(String value){
    tuhurID=value;
    notifyListeners();
  }

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
  setFrom(int value){
    from=value;
    notifyListeners();
  }
  setTimerStart(bool value) {
    isTimerStart = value;
    notifyListeners();
  }
}