import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UserProvider extends ChangeNotifier {
  String uid = '';
  String? location;
  String? beginner;
  String? married;
  String language = 'en';
  late GeoPoint currentPoint;
  bool? login;
  bool arePregnant = false;
  bool bleedingPregnant = false; //only when postnatal period starts
  bool isDarkMode = false;
  bool showFajar = true;
  bool showSunrise = true;
  bool showDuhur = true;
  bool showAsr = true;
  bool showMaghrib = true;
  bool showIsha = true;
  bool showMedicine = true;
  bool showSadqa = true;
  bool showCycle = true;
  int sadqaAmount = 0;
  late Timestamp lastMenses;
  late Timestamp lastMensesEnd;
  late Timestamp lastTuhur;
  late Map<String, int> lastMensesTime;
  Map<String, int>? lastTuhurTime;
  late List<PickerDateRange> mensesDateRange;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> allMensesData;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> allTuhurData;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> allPregnancyData;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> allPostNatalData;

  List<String> medicineIDS = [];
  String get getUid => uid;
  String? get getLanguage => language;

  String? get getLocation => location;

  String? get getBeginner => beginner;

  String? get getMarried => married;

  GeoPoint get getCurrentPoint => currentPoint;

  bool? get getLogin => login;

  bool get getIsDarkMode => isDarkMode;

  bool get getShowFajar => showFajar;

  bool get getShowSunrise => showSunrise;

  bool get getShowDuhur => showDuhur;

  bool get getShowAsr => showAsr;

  bool get getShowMaghrib => showMaghrib;

  bool get getShowIsha => showIsha;
  bool get getShowMedicine => showMedicine;
  bool get getShowSadqa => showSadqa;
  bool get getShowCycle => showCycle;
  bool get getArePregnant => arePregnant;
  bool get getBleedingPregnant => bleedingPregnant;

  int get getSadqaAmount => sadqaAmount;

  Timestamp get getLastMenses => lastMenses;

  Timestamp get getLastMensesEnd => lastMensesEnd;

  Timestamp get getLastTuhur => lastTuhur;

  Map<String, int> get getLastMensesTime => lastMensesTime;

  Map<String, int>? get getLastTuhurTime => lastTuhurTime;

  List<PickerDateRange> get getMensesDateRange => mensesDateRange;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get getMensesData =>
      allMensesData;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get getTuhurData =>
      allTuhurData;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get getPregnancyData =>
      allPregnancyData;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get getPostNatalData =>
      allPostNatalData;

  List<String> get getMedicinesList => medicineIDS;

  setArePregnant(bool value) {
    arePregnant = value;
    notifyListeners();
  }

  setbleedingPregnant(bool value) {
    bleedingPregnant = value;
    notifyListeners();
  }

  setShowCycle(bool value) {
    showCycle = value;
    notifyListeners();
  }

  setShowMedicine(bool value) {
    showMedicine = value;
    notifyListeners();
  }

  setShowSadqa(bool value) {
    showSadqa = value;
    notifyListeners();
  }

  setShowFajar(bool value) {
    showFajar = value;
    notifyListeners();
  }

  setShowSunrise(bool value) {
    showSunrise = value;
    notifyListeners();
  }

  setShowDuhur(bool value) {
    showDuhur = value;
    notifyListeners();
  }

  setShowAsr(bool value) {
    showAsr = value;
    notifyListeners();
  }

  setShowMaghrib(bool value) {
    showMaghrib = value;
    notifyListeners();
  }

  setShowIsha(bool value) {
    showIsha = value;
    notifyListeners();
  }

  setAllTuhurData(List<QueryDocumentSnapshot<Map<String, dynamic>>> value) {
    allTuhurData = value;
    notifyListeners();
  }

  setAllPregnancyData(List<QueryDocumentSnapshot<Map<String, dynamic>>> value) {
    allPregnancyData = value;
    notifyListeners();
  }

  setAllPostNatalData(List<QueryDocumentSnapshot<Map<String, dynamic>>> value) {
    allPostNatalData = value;
    notifyListeners();
  }

  setMedicinesIDS(List<String> value) {
    medicineIDS = value;
    notifyListeners();
  }

  setSadqaAmount(int value) {
    sadqaAmount = value;
    notifyListeners();
  }

  setAllMensesData(List<QueryDocumentSnapshot<Map<String, dynamic>>> value) {
    allMensesData = value;
    notifyListeners();
  }

  setMensesDate(List<PickerDateRange> value) {
    mensesDateRange = value;
    notifyListeners();
  }

  setLastMensesTime(int days, int hour, int minute, int seconds) {
    lastMensesTime = {
      'days': days,
      'hours': hour,
      'minutes': minute,
      'seconds': seconds
    };
    notifyListeners();
  }

  setLastTuhurTime(int days, int hour, int minute, int seconds) {
    lastTuhurTime = {
      'days': days,
      'hours': hour,
      'minutes': minute,
      'seconds': seconds
    };
    notifyListeners();
  }

  setLastMensesEnd(Timestamp value) {
    lastMensesEnd = value;
    notifyListeners();
  }

  setLastMenses(Timestamp value) {
    lastMenses = value;
    notifyListeners();
  }

  setBeginner(String value) {
    beginner = value;
    notifyListeners();
  }

  setMarried(String value) {
    married = value;
    notifyListeners();
  }

  setLastTuhur(Timestamp value) {
    lastTuhur = value;
    notifyListeners();
  }

  setUID(String value) {
    uid = value;
    notifyListeners();
  }

  setLanguage(String value) {
    language = value;
    notifyListeners();
  }

  setLogin(bool value) {
    login = value;
    notifyListeners();
  }

  setLocation(String value) {
    location = value;
    notifyListeners();
  }

  setCurrentPoint(GeoPoint value) {
    currentPoint = value;
    notifyListeners();
  }

  setDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}
