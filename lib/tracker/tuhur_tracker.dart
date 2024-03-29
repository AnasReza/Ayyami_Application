import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
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

  void startTuhurTimer(TuhurProvider tuhurProvider, String uid, int from, bool isMenstrual) {
    tuhurProvider.setFrom(from);
    Future<DocumentReference<Map<String, dynamic>>> tuhur =
        TuhurRecord.uploadTuhurStartTime(uid, from, isMenstrual);
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
    _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp, presetMillisecond: milliseconds);
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

  void stopTuhurTimer(TuhurProvider tuhurProvider, Timestamp endTime) {
    String tuhurID = tuhurProvider.getTuhurID;
    var startTime = tuhurProvider.startTime.toDate();
    var endDate = endTime.toDate();

    var diff = endDate.difference(startTime);
    var map = Utils.timeConverter(diff);
    TuhurRecord.uploadTuhurEndTime(
        tuhurID, map['days']!, map['hours']!, map['minutes']!, map['seconds']!);

    tuhurProvider.setTimerStart(false);
    tuhurProvider.setDays(0);
    tuhurProvider.setHours(0);
    tuhurProvider.setMin(0);
    tuhurProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  void stopTimerWithDeletion(String mensesID, String postNatalID, MensesProvider mensesProvider,
      TuhurProvider tuhurProvider, PostNatalProvider postNatalProvider) {
    TuhurRecord.deleteTuhurID(
        mensesID, postNatalID, tuhurProvider, mensesProvider, postNatalProvider);
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
