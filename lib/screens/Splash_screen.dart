// ignore_for_file: camel_case_types, unused_import

import 'dart:async';
import 'package:ayyami/constants/const.dart';
import 'package:ayyami/firebase_calls/medicine_record.dart';
import 'package:ayyami/models/habit_model.dart';
import 'package:ayyami/providers/habit_provider.dart';
import 'package:ayyami/providers/medicine_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/Questions/Are_you_married.dart';
import 'package:ayyami/screens/settings/choose_language.dart';
import 'package:ayyami/tracker/habit_tracker.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/notification.dart';
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

import '../firebase_calls/user_record.dart';
import '../providers/menses_provider.dart';
import '../translation/app_translation.dart';
import 'Questions/Are_you_beginner.dart';
import 'Questions/where_are_you_from.dart';
import 'main_screen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  int lastMensesDays = 0,
      lastMensesHours = 0,
      lastMensesMinutes = 0,
      lastMensesSeconds = 0;
  int lastTuhurDays = 0,
      lastTuhurHours = 0,
      lastTuhurMinutes = 0,
      lastTuhurSeconds = 0;

  late HabitProvider habitProvider;
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    habitProvider = context.read<HabitProvider>();
    if (user != null) {
      // String uid = user.uid;
      // MensesProvider pro = context.read<MensesProvider>();
      // getLastMenses(uid, pro);
    }
    Timer(const Duration(seconds: 3), () {
      final hiveValue = getHive();
      bool login = hiveValue['login'];
      String uid = hiveValue['uid'];
      print("$hiveValue is hiveValue"); 
      if (login) {
        print('$login login from hive in splash screen');
        // TODO : remove for debug app only
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => first_question(
        //             uid: uid, darkMode: false, fromProfile: false)));
        bool testing = true;
        if (testing == false) {
          String userId = "GpiLskC6SJQNnfu0zqRKup2UBxp1";
          removeAllUserDataFrom("menses", userId);
          removeAllUserDataFrom("tuhur", userId);
          removeAllUserDataFrom("habit", userId);
          removeAllUserDataFrom("pregnancy", userId);
          removeAllUserDataFrom("post-natal", userId);
          // addQuestionaireMock(userId);
          // timestamptest();
          initHabitProv(userId);
        } else {
          print('$login login from hive in splash screen');
          initHabitProv(uid);
          // initUserSettingsOnLogin(uid);
        }
      } else {
        nextScreen(context, const ChooseLanguage());
      }
    });
  }

  initHabitProv(String userId) async {
    HabitModel? habitModel =
        await HabitTracker().getRefreshedHabitDetails(userId);
    if (habitModel != null) {
      habitProvider.setHabitModel(habitModel);
    }
    initUserSettingsOnLogin(userId);
  }

  addQuestionaireMock(String uid) async {
    final mensescoll = FirebaseFirestore.instance.collection('menses');
    final tuhurcoll = FirebaseFirestore.instance.collection('tuhur');
    const previousTuhurTimeStart =
        '6 Jan 2023, 8:00:00 AM'; // previous tuhur start
    const startDateTime = '1 Feb 2023, 8:00:00 AM'; //menses start
    const endDateTime = '6 Feb 2023, 8:00:00 AM'; // menses end

    final dateFormat = DateFormat('d MMM yyyy, hh:mm:ss a');
    Timestamp previousTuhurTimestamp =
        Timestamp.fromDate(dateFormat.parse(previousTuhurTimeStart));
    Timestamp endTimestamp = Timestamp.fromDate(dateFormat.parse(endDateTime));
    Timestamp startTimestamp =
        Timestamp.fromDate(dateFormat.parse(startDateTime));

    var difference = Utils.timeConverter(
        endTimestamp.toDate().difference(startTimestamp.toDate()));
    var diff_last_tuhur = Utils.timeConverter(
        startTimestamp.toDate().difference(previousTuhurTimestamp.toDate()));

    //second last tuhur time 6 Apr to 1 May to get his habit
    await tuhurcoll.add({
      'start_date': previousTuhurTimestamp,
      'end_time': startTimestamp,
      'days': diff_last_tuhur['days'],
      'hours': diff_last_tuhur['hours'],
      'minutes': diff_last_tuhur['minutes'],
      'seconds': diff_last_tuhur['seconds'],
      'uid': uid,
      'from': 0,
      'non_menstrual_bleeding': false,
      'spot': false
    });
    // await pregnancycoll.add({
    //   'start_date': pregnancyStartDateTime,
    //   'end_time': pregnancyEndDateTime,
    //   'days': diff_current_preg['days'],
    //   'hours': diff_current_preg['hours'],
    //   'minutes': diff_current_preg['minutes'],
    //   'seconds': diff_current_preg['seconds'],
    //   'uid': uid,
    //   'reason': 'Miscarriage',
    //   'pregnancy_count': 1
    // });
    HabitModel habitModel = HabitModel(
        uid: uid,
        // habitStartDay:
        //     Utils.addDurationToTimestamp(endTimestamp, diff_last_tuhur),
        habitTuhurDays: diff_last_tuhur['days'] ?? 0,
        habitTuhurHours: diff_last_tuhur['hours'] ?? 0,
        habitTuhurMinutes: diff_last_tuhur['minutes'] ?? 0,
        habitTuhurSeconds: diff_last_tuhur['seconds'] ?? 0,
        habitMensesDays: difference['days'] ?? 0,
        habitMensesHours: difference['hours'] ?? 0,
        habitMensesMinutes: difference['minutes'] ?? 0,
        habitMensesSeconds: difference['seconds'] ?? 0);
    HabitTracker().updateNewHabitForTest(habitModel, habitProvider);
    habitProvider.setHabitModel(habitModel);
    print("1: ${habitProvider.habitModel.toTuhurDurationMap()}");
    //menses time from 1 May to 6 May
    await mensescoll.add({
      'start_date': startTimestamp,
      'end_time': endTimestamp,
      'days': difference['days'],
      'hours': difference['hours'],
      'minutes': difference['minutes'],
      'seconds': difference['seconds'],
      'uid': uid,
      'fromMiscarriageOrDnc': false,
    });
    //now the tuhur time from 6 may to onwards unless he stops the timer
    await tuhurcoll.add({
      'start_date': endTimestamp,
      'uid': uid,
      'from': 0,
      'non_menstrual_bleeding': false
    });

    initUserSettingsOnLogin(uid);
  }

  removeAllUserDataFrom(String coll, String uid) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(coll)
        .where('uid', isEqualTo: uid)
        .get();

    final List<QueryDocumentSnapshot> docs = querySnapshot.docs;

    for (final doc in docs) {
      await doc.reference.delete();
    }
  }

  initUserSettingsOnLogin(String uid) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    var medProvider = Provider.of<MedicineProvider>(context, listen: false);

    UsersRecord().getUsersData(uid).then((value) {
      print("====== USER DATA ======");
      String userId = value.id;
      Map<String, dynamic>? userData = value.data();
      List<int> missingQuestions = List.empty(growable: true);
      print('userId : $userId');
      provider.setUID(userId);
      if (userData!.containsKey('beginner')) {
        provider.setBeginner(userData['beginner']);
      } else {
        missingQuestions.add(1);
        // provider.setBeginner('Beginner');
      }
      if (userData.containsKey('married_unmarried')) {
        provider.setMarried(userData['married_unmarried']);
      } else {
        if (userData.containsKey('beginner') &&
            userData['beginner'] == 'Beginner') {
          //no need to ask married
        } else {
          missingQuestions.add(2);
        }
      }
      if (!userData.containsKey('are_pregnant')) {
        provider.setArePregnant(false);
      }
      if (!userData.containsKey('bleeding_pregnant')) {
        provider.setbleedingPregnant(false);
      }
      if (userData.containsKey('show_sadqa') &&
          userData.containsKey('sadqa_amount') &&
          userData.containsKey('sadqa_reminder')) {
        provider.setSadqaAmount(userData['sadqa_amount']);
        int sadqaAmount = userData['sadqa_amount'];
        if (sadqaAmount != 0) {
          SendNotification().sadqaNotificationTime(
              int.parse(userData['sadqa_reminder'].toString()));
        }
      } else {
        provider.setShowSadqa(true);
        provider.setSadqaAmount(0);
      }

      try {
        provider.setShowCycle(value['show_cycle']);
        provider.setShowFajar(value['show_fajar']);
        provider.setShowSunrise(value['show_sunrise']);
        provider.setShowDuhur(value['show_duhur']);
        provider.setShowAsr(value['show_asr']);
        provider.setShowMaghrib(value['show_maghrib']);
        provider.setShowIsha(value['show_isha']);
      } catch (e) {
        provider.setShowCycle(true);
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
          List<String> medListIDs =
              List<String>.from(value.get('medicine_list'));
          provider.setMedicinesIDS(medListIDs);
          Map<String, dynamic> map = {};
          for (var medId in medListIDs) {
            MedicineRecord().getMedicineData(medId).then((medValue) {
              List<Map<String, dynamic>> timingList =
                  List<Map<String, dynamic>>.from(medValue.get('time_list'));
              var medName = medValue.get('medicine_name');
              var id = medValue.get('medId');

              List<Map<String, dynamic>> tempList = [];
              for (var medMap in timingList) {
                tempList.add(
                    {'timeName': medMap['timeName'], 'time': medMap['time']});
              }

              map = {'timeList': tempList, 'medicine_name': medName, 'id': id};

              for (int x = 0; x < map.length; x++) {
                print(
                    '${map.length}=mapLength   $x=current index $medName=medname  ${map.length + x + 7}   ');
              }

              medProvider.setMedMap(map);
              SendNotification()
                  .medicineNotificationTime(timingList, medName, medProvider);
            });
          }
        }
      } catch (e) {
        provider.setShowMedicine(true);
      }

      try {
        provider.setCurrentPoint(value.get('coordinates'));
      } catch (e) {
        missingQuestions.add(3);
      }
      try {
        provider.setLocation(value.get('location_name'));
      } catch (e) {
        missingQuestions.add(3);
      }
      //continue question where they were left and add the data
      Widget nextWidget;
      if (missingQuestions.contains(1)) {
        nextWidget =
            first_question(uid: uid, darkMode: false, fromProfile: false);
      } else if (missingQuestions.contains(2)) {
        nextWidget =
            second_question(uid: uid, darkMode: false, fromProfile: false);
      } else if (missingQuestions.contains(3)) {
        nextWidget =
            LocationQuestion(uid: userId, darkMode: provider.getIsDarkMode);
      } else {
        nextWidget = MainScreen();
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => nextWidget));
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
        // Timestamp startTime = docList[0].get('end_time');
        // print('${doc.id}=uid from menses collection');
        // break;
      } catch (e) {
        String ex = e.toString();
        print(ex);
        Timestamp startTime = docList[0].get('start_date');
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
          TuhurProvider tuhurPro = context.read<TuhurProvider>();
          getLastTuhur(uid, tuhurPro);
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  Map<String, dynamic> getHive() {
    String? uid;
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
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 230,
          width: 420,
          child: Image.asset("assets/images/logo.png"),
        ),
        const SizedBox(height: 30),
        Text("Ease Your Life With Islamic Tracker".tr,
            style: GoogleFonts.charm(
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: const Color.fromARGB(255, 106, 109, 122),
            )),
        const SizedBox(height: 80),
        const SpinKitCircle(color: Color(0xffD88DBC)),
      ]),
    );
  }
}
