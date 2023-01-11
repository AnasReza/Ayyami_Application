import 'package:flutter/material.dart';

class NamazProvider extends ChangeNotifier{
  String fajrTiming='';
  String sunriseTiming='';
  String duhurTiming='';
  String asrTiming='';
  String maghribTiming='';
  String ishaTiming='';

  String get getFajrTime => fajrTiming;
  String get getSunriseTime => sunriseTiming;
  String get getDuhurTime => duhurTiming;
  String get getAsrTime => asrTiming;
  String get getMaghribTime => maghribTiming;
  String get getIshaTime => ishaTiming;

  void setFajrTime(String value){
    fajrTiming=value;
    notifyListeners();
  }
  void setSunriseTime(String value){
    sunriseTiming=value;
    notifyListeners();
  }
  void setDuhurTime(String value){
    duhurTiming=value;
    notifyListeners();
  }
  void setAsrTime(String value){
    asrTiming=value;
    notifyListeners();
  }
  void setMaghribTime(String value){
    maghribTiming=value;
    notifyListeners();
  }
  void setIshaTime(String value){
    ishaTiming=value;
    notifyListeners();
  }
}