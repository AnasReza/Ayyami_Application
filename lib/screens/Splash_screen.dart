import 'dart:async';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'Login_System/account_create.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () {
      final hiveValue=getHive();
      bool login=hiveValue['login'];
      String uid=hiveValue['uid'];
      if(login){
        var provider=Provider.of<UserProvider>(context,listen: false);
        provider.setUID(uid);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => account_create()));
      }

        });
  }
  Map<String, dynamic> getHive() {
    String uid;
    bool login;
    try {
      var box = Hive.box('aayami');
      uid = box.get('uid');
      login = box.get('login');
    } catch (e) {
      uid = '';
      login = false;
    }

    return {'uid': uid, 'login': login};
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 230,
          width: 420,
          child: Image.asset("assets/images/logo.png"),
        ),
        SizedBox(height: 30),
        Container(
          child: Text("Ease Your Life With Islamic Tracker".tr,
              style: GoogleFonts.charm(
                fontStyle: FontStyle.normal,
                fontSize: 18,
                color: Color.fromARGB(255, 106, 109, 122),
              )),
        ),
        SizedBox(height: 80),
        SpinKitCircle(color: Color(0xffD88DBC)),
      ]),
    );
  }
}
