import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MensesProvider extends ChangeNotifier {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  bool isTimerStart = false;
  String mensesID = '';
  late Timestamp startTime;

  int get getSec => seconds;

  int get getmin => minutes;
  int get getHours => hours;
  int get getDays => days;

  bool get getTimerStart => isTimerStart;

  String get getMensesID => mensesID;
  Timestamp get getStartTime => startTime;

  setMensesID(String value) {
    mensesID = value;
    notifyListeners();
  }

  setStartTime(Timestamp value) {
    startTime = value;
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

  setHours(int value) {
    hours = value;
    notifyListeners();
  }

  setDays(int value) {
    days = value;
    notifyListeners();
  }

  setTimerStart(bool value) {
    isTimerStart = value;
    notifyListeners();
  }

  resetValue() {
    seconds = 0;
    minutes = 0;
    hours = 0;
    hours = 0;
    days = 0;
    isTimerStart = false;
    mensesID = '';
    startTime = Timestamp(0, 0);
    notifyListeners();
  }
}
