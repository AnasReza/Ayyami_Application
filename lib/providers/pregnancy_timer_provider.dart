import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PregnancyProvider extends ChangeNotifier {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  int weeks = 0;
  late Timestamp startTime;
  bool isTimerStart = false;
  String pregnancyID = '';

  int get getSec => seconds;

  int get getmin => minutes;
  int get getHours => hours;
  int get getDays => days;
  int get getWeeks => weeks;

  bool get getTimerStart => isTimerStart;
  String get getPregnancyId => pregnancyID;
  Timestamp get getStartTime => startTime;

  setSec(int value) {
    seconds = value;
    notifyListeners();
  }

  setStartTime(Timestamp value) {
    startTime = value;
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

  setWeeks(int value) {
    weeks = value;
    notifyListeners();
  }

  setTimerStart(bool value) {
    isTimerStart = value;
    notifyListeners();
  }

  setPregnancyID(String value) {
    pregnancyID = value;
    notifyListeners();
  }

  resetValue() {
    seconds = 0;
    minutes = 0;
    hours = 0;
    days = 0;
    weeks = 0;
    startTime = Timestamp(0, 0);
    isTimerStart = false;
    pregnancyID = '';
    notifyListeners();
  }
}
