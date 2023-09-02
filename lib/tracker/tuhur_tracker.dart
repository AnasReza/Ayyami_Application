import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../providers/menses_provider.dart';
import '../providers/tuhur_provider.dart';
import '../utils/utils.dart';

class TuhurTracker {
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  late var _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);
  addPreviousQuestionTuhur(String uid, Timestamp startTime, Timestamp endTime) {
    //when the user is beginner and enters its first menses
    //no previous tuhur is there so we adding 15 days minimum valid time so our flow doesnt disturbed
    return TuhurRecord.addBeginnersTuhurDoc(uid, startTime, endTime);
  }

  void startTuhurTimerAfterQuestionaire(TuhurProvider tuhurProvider,
      Timestamp startTime, String uid, int from, bool isMenstrual) {
    tuhurProvider.setFrom(from);
    Future<DocumentReference<Map<String, dynamic>>> tuhur =
        TuhurRecord.uploadTuhurStartSpecificTime(
            uid, startTime, from, isMenstrual);
    tuhur.then((value) {
      Utils.saveDocTuhurId(value.id);
      tuhurProvider.setTuhurID(value.id);
      print('${value.id} record doc id');
    });

    _stopWatch.secondTime.listen((event) {
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

  static void continueLastTuhurWithDeletion(Timestamp startTuhurDate,
      UserProvider userProvider, TuhurProvider tuhurProvider) {
    //start latest tuhur again
    TuhurRecord.startLastTuhurAgain(
        userProvider.getTuhurData[0].id, tuhurProvider, startTuhurDate);
    //delete this tuhur
    // FirebaseFirestore.instance
    //     .collection('tuhur')
    //     .doc(tuhurProvider.getTuhurID)
    //     .delete()
    //     .then((value) => {});
  }

  void startTuhurTimer(TuhurProvider tuhurProvider, String uid, int from,
      bool isMenstrual, Timestamp startTime) {
    tuhurProvider.setFrom(from);
    Future<DocumentReference<Map<String, dynamic>>> tuhur =
        TuhurRecord.uploadTuhurStartSpecificTime(
            uid, startTime, from, isMenstrual);
    // TuhurRecord.uploadTuhurStartTime(uid, from, isMenstrual, startTime);
    tuhur.then((value) {
      Utils.saveDocTuhurId(value.id);
      tuhurProvider.setTuhurID(value.id);
      print('${value.id} record doc id');
    });

    _stopWatch.secondTime.listen((event) {
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

  void startTuhurTimerAgain(TuhurProvider tuhurProvider, int milliseconds) {
    var timeMap = Utils.timeConverter(Duration(milliseconds: milliseconds));
    secondsCount = timeMap['seconds']!;
    minutesCount = timeMap['minutes']!;
    hoursCount = timeMap['hours']!;
    daysCount = timeMap['days']!;
    tuhurProvider.setDays(daysCount);
    tuhurProvider.setHours(hoursCount);
    tuhurProvider.setMin(minutesCount);
    tuhurProvider.setSec(secondsCount);
    _stopWatch = StopWatchTimer(
        mode: StopWatchMode.countUp, presetMillisecond: milliseconds);
    _stopWatch.secondTime.listen((event) {
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
    print(
        "tuhur Tracker is started with: ${tuhurProvider.getDays}:${tuhurProvider.getHours}:${tuhurProvider.getmin}:${tuhurProvider.getSec}");
    _stopWatch.onStartTimer();
  }

  void stopTuhurTimer(TuhurProvider tuhurProvider, Timestamp endTime) {
    String tuhurID = tuhurProvider.getTuhurID;
    var startTime = tuhurProvider.startTime.toDate();
    var endDate = endTime.toDate();

    var diff = endDate.difference(startTime);
    var map = Utils.timeConverter(diff);
    TuhurRecord.uploadTuhurEndTime(tuhurID, map['days']!, map['hours']!,
        map['minutes']!, map['seconds']!, endTime);

    tuhurProvider.setTimerStart(false);
    tuhurProvider.setDays(0);
    tuhurProvider.setHours(0);
    tuhurProvider.setMin(0);
    tuhurProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  void stopTimerWithDeletion(
      String mensesID,
      String postNatalID,
      MensesProvider mensesProvider,
      TuhurProvider tuhurProvider,
      UserProvider userProvider,
      PostNatalProvider postNatalProvider) {
    TuhurRecord.deleteTuhurID(mensesID, postNatalID, tuhurProvider,
        mensesProvider, postNatalProvider, userProvider);
    tuhurProvider.setTimerStart(false);
    tuhurProvider.setDays(0);
    tuhurProvider.setHours(0);
    tuhurProvider.setMin(0);
    tuhurProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  void resetValue(TuhurProvider provider) {
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
    provider.resetValue();
  }
}
