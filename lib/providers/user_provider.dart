import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  String? uid;
  bool? login;

  String? get getUid=> uid;
  bool? get getLogin=>login;

  setUID(String value){
    uid=value;
    notifyListeners();
  }
  setLogin(bool value){
    login=value;
    notifyListeners();
  }


}