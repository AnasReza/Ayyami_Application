import 'package:flutter/material.dart';

class NamazProvider extends ChangeNotifier{
  String fajrTiming='';
  String sunriseTiming='';
  String duhurTiming='';
  String asrTiming='';
  String maghribTiming='';
  String ishaTiming='';
  DateTime fajrDateTime=DateTime(2023);
  DateTime sunriseDateTime=DateTime(2023);
  DateTime duhurDateTime=DateTime(2023);
  DateTime asrDateTime=DateTime(2023);
  DateTime maghribDateTime=DateTime(2023);
  DateTime ishaDateTime=DateTime(2023);

  String get getFajrTime => fajrTiming;
  String get getSunriseTime => sunriseTiming;
  String get getDuhurTime => duhurTiming;
  String get getAsrTime => asrTiming;
  String get getMaghribTime => maghribTiming;
  String get getIshaTime => ishaTiming;
  DateTime get getFajrDateTime => fajrDateTime;
  DateTime get getSunriseDateTime => sunriseDateTime;
  DateTime get getDuhurDateTime => duhurDateTime;
  DateTime get getAsrDateTime => asrDateTime;
  DateTime get getMaghribDateTime => maghribDateTime;
  DateTime get getIshaDateTime => ishaDateTime;


  void setFajarDateTime(DateTime value){
    fajrDateTime=value;
    notifyListeners();
  }
  void setSunriseDateTime(DateTime value){
    sunriseDateTime=value;
    notifyListeners();
  }
  void setDuhurDateTime(DateTime value){
    duhurDateTime=value;
    notifyListeners();
  }
  void setAsrDateTime(DateTime value){
    asrDateTime=value;
    notifyListeners();
  }
  void setMaghribDateTime(DateTime value){
    maghribDateTime=value;
    notifyListeners();
  }
  void setIshaDateTime(DateTime value){
    ishaDateTime=value;
    notifyListeners();
  }
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