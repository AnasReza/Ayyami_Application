import 'dart:async';

import 'package:ayyami/constants/const.dart';
import 'package:ayyami/firebase_calls/medicine_record.dart';
import 'package:ayyami/providers/medicine_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/settings/choose_language.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../firebase_calls/user_record.dart';
import '../providers/menses_provider.dart';
import 'main_screen.dart';

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
      print('$login login from hive in splash screen');
      if (login) {
        UsersRecord().getUsersData(uid).then((value) {
          var provider = Provider.of<UserProvider>(context, listen: false);
          var medProvider = Provider.of<MedicineProvider>(context, listen: false);
          print('${value.id}  user id');
          provider.setUID(value.id);
          try {
            provider.setShowSadqa(value['show_sadqa']);
            if (provider.getShowSadqa) {
              provider.setSadqaAmount(value['sadqa_amount']);
              int sadqaAmount = value['sadqa_amount'];
              if (sadqaAmount != 0) {
                SendNotification()
                    .sadqaNotificationTime(int.parse(value['sadqa_reminder'].toString()));
              }
            }
          } catch (e) {
            provider.setShowSadqa(true);
          }
          try {
            provider.setShowCycle(value['show_cycle']);
          } catch (e) {
            provider.setShowCycle(true);
          }

          try {
            provider.setShowFajar(value['show_fajar']);
            provider.setShowSunrise(value['show_sunrise']);
            provider.setShowDuhur(value['show_duhur']);
            provider.setShowAsr(value['show_asr']);
            provider.setShowMaghrib(value['show_maghrib']);
            provider.setShowIsha(value['show_isha']);
          } catch (e) {
            provider.setShowFajar(true);
            provider.setShowSunrise(true);
            provider.setShowDuhur(true);
            provider.setShowAsr(true);
            provider.setShowMaghrib(true);
            provider.setShowIsha(true);
          }
          try {
            provider.setDarkMode(value.get('dark-mode'));
          } catch (e) {
            provider.setDarkMode(false);
          }
          try {
            provider.setLanguage(value.get('language'));
          } catch (e) {
            provider.setLanguage('en');
          }
          try {
            provider.setShowMedicine(value.get('show_medicine'));
            if (provider.getShowMedicine) {
              List<String> medListIDs = List<String>.from(value.get('medicine_list'));
              provider.setMedicinesIDS(medListIDs);
              print('${medListIDs.length} length of med list');
              Map<String, dynamic> map = {};
              for (var medId in medListIDs) {
                MedicineRecord().getMedicineData(medId).then((medValue) {
                  List<Map<String, dynamic>> timingList =
                      List<Map<String, dynamic>>.from(medValue.get('time_list'));
                  var medName = medValue.get('medicine_name');
                  var id = medValue.get('medId');

                  List<Map<String, dynamic>> tempList = [];
                  for (var medMap in timingList) {
                    tempList.add({'timeName': medMap['timeName'], 'time': medMap['time']});
                  }

                  map = {'timeList': tempList, 'medicine_name': medName, 'id': id};

                  for (int x = 0; x < map.length; x++) {
                    print(
                        '${map.length}=mapLength   $x=current index $medName=medname  ${map.length + x + 7}   ');
                  }

                  medProvider.setMedMap(map);
                  SendNotification().medicineNotificationTime(timingList, medName, medProvider);
                });
              }
            }
          } catch (e) {
            provider.setShowMedicine(true);
          }

          provider.setCurrentPoint(value.get('coordinates'));
          provider.setLocation('location_name');

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
        });
      } else {
        nextScreen(context, ChooseLanguage());
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
        Timestamp startTime = docList[0].get('start_time');
        Timestamp now = Timestamp.now();
        var diff = now.toDate().difference(startTime.toDate());
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
      try {
        if (docList.isNotEmpty) {
          Timestamp endTime = docList[0].get('end_time');
          TuhurProvider tuhurPro = context.read<TuhurProvider>();
          getLastTuhur(uid, tuhurPro);
        }
      } catch (e) {
        if (docList.isNotEmpty) {
          Timestamp startTime = docList[0].get('start_time');
          Timestamp now = Timestamp.now();
          var diff = now.toDate().difference(startTime.toDate());
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
      print('${e.toString()} error from splash screen');
      uid = '';
      login = false;
    }

    return {
      'uid': uid,
      'login': login,
    };
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
