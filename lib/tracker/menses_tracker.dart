import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../firebase_calls/menses_record.dart';
import '../providers/tuhur_provider.dart';

class MensesTracker {
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  final TuhurTracker tuhurTracker = TuhurTracker();
  final _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startMensisTimer(MensesProvider mensesProvider, String uid, TuhurProvider tuhurProvider) {
    var startTime=Timestamp.now();
    var menses = MensesRecord.uploadMensesStartTime(uid,startTime);
    menses.then((value) {
      saveDocId(value.id);
      mensesProvider.setMensesID(value.id);
      mensesProvider.setStartTime(startTime);
      tuhurTracker.stopTuhurTimer(tuhurProvider);
      print('${value.id} record doc id');
    });
    _stopWatch.secondTime.listen((event) {
      print('$secondsCount==sec    $minutesCount==minutes');
      secondsCount++;
      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
            // if (daysCount > 30) {
            //   daysCount = 0;
            // }
            mensesProvider.setDays(daysCount);
            hoursCount = 0;
          }
          mensesProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        // else if (minutesCount == 10) {
        //   stopMensesTimer(mensesProvider, tuhurProvider, uid);
        // }

        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }

      mensesProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void stopMensesTimer(MensesProvider mensesProvider, TuhurProvider tuhurProvider, String uid) {
    tuhurTracker.startTuhurTimer(tuhurProvider, uid);
    String mensesID = mensesProvider.getMensesID;
    Timestamp startTime=mensesProvider.getStartTime;
    var diff= Timestamp.now().toDate().difference(startTime.toDate());
    if(diff.inDays<=10){
      MensesRecord.uploadMensesEndTime(mensesID, daysCount, hoursCount, minutesCount, secondsCount);
      mensesProvider.setTimerStart(false);
      mensesProvider.setDays(0);
      mensesProvider.setHours(0);
      mensesProvider.setMin(0);
      mensesProvider.setSec(0);
      _stopWatch.onStopTimer();
      _stopWatch.onResetTimer();
    }

  }

  static void saveDocId(String id) async {
    var box = await Hive.openBox('aayami_menses');
    box.put('menses_timer_doc_id', id);
  }

  dynamic getDocID() async {
    var box = await Hive.openBox('aayami_menses');
    return box.get('menses_timer_doc_id');
  }
}
