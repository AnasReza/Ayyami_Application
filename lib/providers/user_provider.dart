import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UserProvider extends ChangeNotifier{
  String uid='';
  String? location;
  String? beginner;
  String? married;
  String language='en';
  late GeoPoint currentPoint;
  bool? login;
  bool isDarkMode=false;
  int sadqaAmount=0;
  late Timestamp lastMenses;
  late Timestamp lastMensesEnd;
  late Timestamp lastTuhur;
  late Map<String, int> lastMensesTime;
  Map<String, int>? lastTuhurTime;
  late List<PickerDateRange> mensesDateRange;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> allMensesData;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> allTuhurData;
  List<String> medicineIDS=[];

  String get getUid=> uid;
  String? get getLanguage=> language;
  String? get getLocation=> location;
  String? get getBeginner=> beginner;
  String? get getMarried=> married;
  GeoPoint get getCurrentPoint=> currentPoint;
  bool? get getLogin=>login;
  bool get getIsDarkMode=>isDarkMode;
  int get getSadqaAmount=>sadqaAmount;
  Timestamp get getLastMenses => lastMenses;
  Timestamp get getLastMensesEnd => lastMensesEnd;
  Timestamp get getLastTuhur => lastTuhur;
  Map<String, int> get getLastMensesTime => lastMensesTime;
  Map<String, int>? get getLastTuhurTime => lastTuhurTime;
  List<PickerDateRange> get getMensesDateRange => mensesDateRange;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get getMensesData => allMensesData;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get getTuhurData => allTuhurData;
  List<String> get getMedicinesList => medicineIDS;

  setAllTuhurData(List<QueryDocumentSnapshot<Map<String, dynamic>>> value) {

    allTuhurData= value;
    notifyListeners();
  }
  setMedicinesIDS(List<String> value) {

    medicineIDS= value;
    notifyListeners();
  }
  setSadqaAmount(int value) {
    sadqaAmount= value;
    notifyListeners();
  }
  setAllMensesData(List<QueryDocumentSnapshot<Map<String, dynamic>>> value) {

    allMensesData= value;
    notifyListeners();
  }
  setMensesDate(List<PickerDateRange> value) {

    mensesDateRange= value;
    notifyListeners();
  }
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
  setBeginner(String value){
    beginner=value;
    notifyListeners();
  }
  setMarried(String value){
    married=value;
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
  setLanguage(String value){
    language=value;
    notifyListeners();
  }
  setLogin(bool value){
    login=value;
    notifyListeners();
  }

  setLocation(String value){
    location=value;
    notifyListeners();
  }
  setCurrentPoint(GeoPoint value){
    currentPoint=value;
    notifyListeners();
  }
  setDarkMode(bool value){
    isDarkMode=value;
    notifyListeners();
  }

}