import 'dart:ui';
import 'package:get/get.dart';  
import 'package:flutter/material.dart';

class MyController extends GetxController{
  void changeLanguage(var param1 , var param2){
    var locate = Locale(param1,param2);
    Get.updateLocale(locate);
  }
}

