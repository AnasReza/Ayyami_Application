import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../providers/menses_provider.dart';
import '../providers/tuhur_provider.dart';

class TuhurTracker{
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  final _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startTuhurTimer(TuhurProvider tuhurProvider, String uid) {
    Future<DocumentReference<Map<String, dynamic>>> tuhur = TuhurRecord.uploadTuhurStartTime(uid);
    tuhur.then((value) {
      saveDocId(value.id);

      tuhurProvider.setTuhurID(value.id);
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
            if (daysCount > 30) {
              daysCount = 0;
            }
            tuhurProvider.setDays(daysCount);
            hoursCount = 0;
          }
          tuhurProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        tuhurProvider.setMin(minutesCount);
        secondsCount = 0;
      }
      tuhurProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void stopTuhurTimer(TuhurProvider tuhurProvider){
    String tuhurID=tuhurProvider.getTuhurID;
    TuhurRecord.uploadMensesEndTime(tuhurID,daysCount,hoursCount,minutesCount,secondsCount);

    tuhurProvider.setTimerStart(false);
    tuhurProvider.setDays(0);
    tuhurProvider.setHours(0);
    tuhurProvider.setMin(0);
    tuhurProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
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