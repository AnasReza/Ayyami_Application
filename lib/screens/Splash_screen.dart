import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
     ()=>Navigator.pushReplacement(context,
     MaterialPageRoute(builder: (context) => account_create())));
    
  }

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;


    return Scaffold(
      
   backgroundColor: Color(0xffF5F5F5),
     body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 230,
          width: 420,
          child: Image.asset("assets/images/logo.png"),
             ),
   
           SizedBox(height: 30),

             Container(
               child: Text(
              "Ease Your Life With Islamic Tracker".tr,
               style: GoogleFonts.charm(
               fontStyle: FontStyle.normal,
               fontSize: 18,
               color:Color.fromARGB(255, 106, 109, 122),
               ) 
              ),
             ),
            
             SizedBox(height: 80),

             SpinKitCircle(color: Color(0xffD88DBC)),
           
      ]
     ),       
    );
  }
}