import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  String? uid;
  bool? login;
  late Timestamp lastMenses;
  late Timestamp lastMensesEnd;
  late Timestamp lastTuhur;
  late Map<String, int> lastMensesTime;
  Map<String, int>? lastTuhurTime;

  String? get getUid=> uid;
  bool? get getLogin=>login;
  Timestamp get getLastMenses => lastMenses;
  Timestamp get getLastMensesEnd => lastMensesEnd;
  Timestamp get getLastTuhur => lastTuhur;
  Map<String, int> get getLastMensesTime => lastMensesTime;
  Map<String, int>? get getLastTuhurTime => lastTuhurTime;

  setLastMensesTime(int days,int hour,int minute,int seconds) {

    lastMensesTime= {'day':days,'hour':hour,'minute':minute,'second':seconds};
    notifyListeners();
  }
  setLastTuhurTime(int days,int hour,int minute,int seconds) {

    lastTuhurTime= {'day':days,'hours':hour,'minutes':minute,'second':seconds};
    notifyListeners();
  }
  setLastMensesEnd(Timestamp value){
    lastMensesEnd=value;
    notifyListeners();
  }
  setLastMenses(Timestamp value){
    lastMenses=value;
    notifyListeners();
  }
  setLastTuhur(Timestamp value){
    lastTuhur=value;
    notifyListeners();
  }

  setUID(String value){
    uid=value;
    notifyListeners();
  }
  setLogin(bool value){
    login=value;
    notifyListeners();
  }


}