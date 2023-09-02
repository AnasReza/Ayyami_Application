import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostNatalProvider extends ChangeNotifier {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  bool isTimerStart = false;
  late Timestamp startTime;
  String postNatalID = '';
  int pregnancyCount = 0;

  int get getSec => seconds;

  int get getmin => minutes;
  int get getHours => hours;
  int get getDays => days;
  int get getPregnancyCount => pregnancyCount;

  bool get getTimerStart => isTimerStart;
  String get getpostNatalID => postNatalID;
  Timestamp get getStartTime => startTime;

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

  setPregnancyCount(int value) {
    pregnancyCount = value;
    notifyListeners();
  }

  setTimerStart(bool value) {
    isTimerStart = value;
    notifyListeners();
  }

  setStartTime(Timestamp value) {
    startTime = value;
    notifyListeners();
  }

  setPostNatalID(String value) {
    postNatalID = value;
    notifyListeners();
  }

  resetStopWatchTimer() {
    seconds = 0;
    minutes = 0;
    hours = 0;
    days = 0;
    isTimerStart = false;
    startTime = Timestamp(0, 0);
    notifyListeners();
  }

  resetValue() {
    seconds = 0;
    minutes = 0;
    hours = 0;
    days = 0;
    isTimerStart = false;
    startTime = Timestamp(0, 0);
    postNatalID = '';
    pregnancyCount = 0;
    notifyListeners();
  }
}
