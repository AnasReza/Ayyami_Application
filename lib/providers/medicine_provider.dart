import 'package:flutter/material.dart';

class MedicineProvider extends ChangeNotifier {
  List<Map<String, dynamic>> medMap = [];

  List<Map<String, dynamic>> get getMap => medMap;


  void setMedMap( Map<String, dynamic>value){
    medMap.add(value);
    notifyListeners();
  }

  void updateMedMap( List<Map<String, dynamic>>value){
    medMap=value;
    notifyListeners();
  }
}
