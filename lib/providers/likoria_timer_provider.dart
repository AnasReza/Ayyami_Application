import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikoriaTimerProvider extends ChangeNotifier {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  bool isTimerStart = false;
  bool isSelected = false;
  String id='';
  Color selectedColor=Colors.white;
  Timestamp startTime=Timestamp(0, 0);

  int get getSec => seconds;

  int get getmin => minutes;
  int get getHours => hours;
  int get getDays => days;

  bool get getTimerStart => isTimerStart;
  bool get getisSelected => isSelected;
  String get getID => id;
  Color get getSelectedColor => selectedColor;
  Timestamp get getStartTime => startTime;

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
  setID(String value) {
    id = value;
    notifyListeners();
  }
  setIsSelected(bool value) {
    isSelected = value;
    notifyListeners();
  }
  setSelectedColor(Color value) {
    selectedColor = value;
    notifyListeners();
  }
  setStartTime(Timestamp value) {
    startTime = value;
    notifyListeners();
  }
}
