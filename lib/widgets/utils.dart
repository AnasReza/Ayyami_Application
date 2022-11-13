import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class toast_notification{

  void toast_message(String msg_notified){
    Fluttertoast.showToast(
      msg: msg_notified,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.purple,
      textColor: Colors.white,
      fontSize: 16,
    
    );

  }

}