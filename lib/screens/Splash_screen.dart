import 'dart:async';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/main_screen.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../firebase_calls/user_record.dart';
import '../providers/menses_provider.dart';
import 'Login_System/account_create.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  int lastMensesDays = 0, lastMensesHours = 0, lastMensesMinutes = 0, lastMensesSeconds = 0;
  int lastTuhurDays = 0, lastTuhurHours = 0, lastTuhurMinutes = 0, lastTuhurSeconds = 0;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      MensesProvider pro = context.read<MensesProvider>();
      // getLastMenses(uid, pro);
    }
    Timer(Duration(seconds: 3), () {
      final hiveValue = getHive();
      bool login = hiveValue['login'];
      String uid = hiveValue['uid'];
      if (login) {
        UsersRecord().getUsersData(uid).then((value){
          var provider = Provider.of<UserProvider>(context, listen: false);
          provider.setUID(value.id);
          provider.setCurrentPoint(value.get('coordinates'));
          provider.setLocation('location_name');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
        });

      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => account_create()));
      }
    });
  }

  getLastTuhur(String uid, TuhurProvider pro) {
    FirebaseFirestore.instance
        .collection('tuhur')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      try {
        Timestamp startTime = docList[0].get('end_time');
        // print('${doc.id}=uid from menses collection');
        // break;
      } catch (e) {
        Timestamp startTime=docList[0].get('start_time');
        Timestamp now=Timestamp.now();
        var diff=now.toDate().difference(startTime.toDate());
        TuhurTracker().startTuhurTimerAgain(pro, diff.inMilliseconds);
      }
    });
  }

  getLastMenses(String uid, MensesProvider pro) {
    FirebaseFirestore.instance
        .collection('menses')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .limit(1)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      try{
        if(docList.isNotEmpty){
          Timestamp endTime = docList[0].get('end_time');
          TuhurProvider tuhurPro=context.read<TuhurProvider>();
          getLastTuhur(uid, tuhurPro);
        }

      }catch(e){
        if(docList.isNotEmpty){
          Timestamp startTime=docList[0].get('start_time');
          Timestamp now=Timestamp.now();
          var diff=now.toDate().difference(startTime.toDate());
          // MensesTracker().startMensisTimerWithTime(pro, uid, diff.inMilliseconds,startTime);
        }

      }

      print('${event.size} size');
      // try {
      //   for (var doc in docList) {
      //
      //     getLastTuhur(uid, pro);
      //     print('${doc.id}=uid from menses collection');
      //   }
      // } catch (e) {}
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
