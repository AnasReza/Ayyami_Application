import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
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
  late var _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startMensisTimer(MensesProvider mensesProvider, String uid, TuhurProvider tuhurProvider,Timestamp startTime) {
    // var startTime = Timestamp.now();
    var menses = MensesRecord.uploadMensesStartTime(uid, startTime);
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
  void startMensisTimerWithTime(MensesProvider mensesProvider, String uid,int milliseconds) {
    _stopWatch=StopWatchTimer(mode: StopWatchMode.countUp,presetMillisecond: milliseconds);
    var startTime = Timestamp.now();
    var menses = MensesRecord.uploadMensesStartTime(uid, startTime);
    menses.then((value) {
      saveDocId(value.id);
      mensesProvider.setMensesID(value.id);
      mensesProvider.setStartTime(startTime);
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

  void stopMensesTimer(
      MensesProvider mensesProvider, TuhurProvider tuhurProvider, String uid, UserProvider userProvider,Timestamp endTime) {
    tuhurTracker.startTuhurTimer(tuhurProvider, uid);
    String mensesID = mensesProvider.getMensesID;
    Timestamp startTime = mensesProvider.getStartTime;
    var diff = endTime.toDate().difference(startTime.toDate());
    if (diff.inDays <= 10) {
      uploadMensesEndTime(mensesID, daysCount, hoursCount, minutesCount, secondsCount, mensesProvider);
    } else {
      var lastMensesStartTime = userProvider.getLastMenses;
      var lastMensesEndTime = userProvider.getLastMenses;
      var currentMenses = mensesProvider.getStartTime;
      var now = endTime;

      var lastStartDay = lastMensesStartTime.toDate();
      var lastEndDay = lastMensesEndTime.toDate();
      var currentMensesStartDay = currentMenses.toDate();
      var currentMensesEndDay = now.toDate();

      var assumptionValue = assumptionOfMenses(userProvider, lastStartDay, lastEndDay);
      var assumptionStart = assumptionValue['start'];
      var assumptionEnd = assumptionValue['end'];

      if (currentMensesStartDay.isAtSameMomentAs(assumptionStart!) &&
          currentMensesEndDay.isAtSameMomentAs(assumptionEnd!)) {
        // var diff = assumptionEnd.difference(assumptionStart);
        uploadMensesEndTime(mensesID, daysCount, hoursCount, minutesCount, secondsCount, mensesProvider);
      } else if (currentMensesStartDay.isAtSameMomentAs(assumptionStart!) &&
          currentMensesEndDay.isBefore(assumptionEnd!)) {
        var diff = currentMensesEndDay.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
        } else {
          //STOP THE MENSES TIMER AND ADD IT TO THE MENSES COLLECTION
          uploadMensesEndTime(mensesID, days, hours, minutes, seconds, mensesProvider);
        }
      } else if (currentMensesStartDay.isAtSameMomentAs(assumptionStart!) &&
          currentMensesEndDay.isAfter(assumptionEnd!)) {
        var diff = assumptionEnd.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          var currentDiff = currentMensesEndDay.difference(currentMensesStartDay);
          var currentMap = Utils.timeConverter(currentDiff);
          int currentDays = currentMap['days']!;
          int currentHours = currentMap['hours']!;
          int currentMinutes = currentMap['minutes']!;
          int currentSeconds = currentMap['seconds']!;
          if (currentMap['days']! < 3) {
            stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          } else {
            uploadMensesEndTime(mensesID, currentDays, currentHours, currentMinutes, currentSeconds, mensesProvider);
          }
        } else {
          //STOP THE MENSES TIMER AND ADD IT TO THE MENSES COLLECTION
          uploadMensesEndTime(mensesID, days, hours, minutes, seconds, mensesProvider);
        }
      } else if (currentMensesStartDay.isBefore(assumptionStart!) &&
          currentMensesEndDay.isAtSameMomentAs(assumptionEnd!)) {
        var diff = currentMensesEndDay.difference(assumptionStart);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if(days<3){
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
        }else{
          uploadMensesEndTime(mensesID, days, hours, minutes, seconds, mensesProvider);
        }
      } else if (currentMensesStartDay.isBefore(assumptionStart!) && currentMensesEndDay.isAfter(assumptionEnd!)) {
        var diff = assumptionEnd.difference(assumptionStart);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if(days<3){
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
        }else{
          uploadMensesEndTime(mensesID, days, hours, minutes, seconds, mensesProvider);
        }
      } else if (currentMensesStartDay.isBefore(assumptionStart!) && currentMensesEndDay.isBefore(assumptionEnd!)) {
        var diff = currentMensesEndDay.difference(assumptionStart);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if(days<3){
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
        }else{
          uploadMensesEndTime(mensesID, days, hours, minutes, seconds, mensesProvider);
        }
      } else if (currentMensesStartDay.isAfter(assumptionStart!) &&
          currentMensesEndDay.isAtSameMomentAs(assumptionEnd!)) {
        var diff = assumptionEnd.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if(days<3){
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
        }else{
          uploadMensesEndTime(mensesID, days, hours, minutes, seconds, mensesProvider);
        }
      } else if (currentMensesStartDay.isAfter(assumptionStart!) && currentMensesEndDay.isBefore(assumptionEnd!)) {
        var diff = currentMensesEndDay.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if(days<3){
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
        }else{
          uploadMensesEndTime(mensesID, days, hours, minutes, seconds, mensesProvider);
        }
      } else if (currentMensesStartDay.isAfter(assumptionStart!) && currentMensesEndDay.isAfter(assumptionEnd!)) {
        var diff = assumptionEnd.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if(days<3){
          var currentDiff=currentMensesEndDay.difference(currentMensesStartDay);
          var currentMap=Utils.timeConverter(currentDiff);
          int currentDays = currentMap['days']!;
          int currentHours = currentMap['hours']!;
          int currentMinutes = currentMap['minutes']!;
          int currentSeconds = currentMap['seconds']!;
          if(currentDays<3){
            stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          }else{
            uploadMensesEndTime(mensesID, currentDays, currentHours, currentMinutes, currentSeconds, mensesProvider);
          }
        }else{
          uploadMensesEndTime(mensesID, days, hours, minutes, seconds, mensesProvider);
        }
      }
    }
  }

  void stopTimerWithDeletion(String mensesID, MensesProvider mensesProvider, TuhurProvider tuhurProvider) {
    MensesRecord.deleteMensesID(mensesID, tuhurProvider);
    mensesProvider.setTimerStart(false);
    mensesProvider.setDays(0);
    mensesProvider.setHours(0);
    mensesProvider.setMin(0);
    mensesProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  void uploadMensesEndTime(String mensesID, int daysCount, int hoursCount, int minutesCount, int secondsCount,
      MensesProvider mensesProvider) {
    MensesRecord.uploadMensesEndTime(mensesID, daysCount, hoursCount, minutesCount, secondsCount);
    mensesProvider.setTimerStart(false);
    mensesProvider.setDays(0);
    mensesProvider.setHours(0);
    mensesProvider.setMin(0);
    mensesProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  Map<String, DateTime> assumptionOfMenses(UserProvider provider, DateTime startTime, DateTime endTime) {
    var tuhurTimeMap = provider.getLastTuhurTime;
    var mensesTimeMap = provider.getLastMensesTime;
    Duration tuhurDuration = Duration(
        days: tuhurTimeMap!['day']!,
        hours: tuhurTimeMap!['hours']!,
        minutes: tuhurTimeMap!['minutes']!,
        seconds: tuhurTimeMap!['second']!);
    Duration mensesDuration = Duration(
        days: mensesTimeMap!['day']!,
        hours: mensesTimeMap!['hours']!,
        minutes: mensesTimeMap!['minutes']!,
        seconds: mensesTimeMap!['second']!);
    var menses_should_start = startTime.add(tuhurDuration);
    var menses_should_end = menses_should_start.add(mensesDuration);
    return {'start': menses_should_start, 'end': menses_should_end};
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
