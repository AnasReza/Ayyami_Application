import 'package:ayyami/firebase_calls/likoria_record.dart';
import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/likoria_timer_provider.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../providers/menses_provider.dart';
import '../providers/tuhur_provider.dart';
import '../utils/utils.dart';

class LikoriaTracker {
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  late var _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startLikoriaTimer(
      LikoriaTimerProvider likoriaProvider, String uid, Timestamp startTime, int colorInt) {
    Future<DocumentReference<Map<String, dynamic>>> tuhur =
        LikoriaRecord().uploadLikoriaStartTime(uid, startTime, colorInt);
    tuhur.then((value) {
      Utils.saveDocLikoriaId(value.id);

      likoriaProvider.setID(value.id);
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
            likoriaProvider.setDays(daysCount);
            hoursCount = 0;
          }
          likoriaProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        likoriaProvider.setMin(minutesCount);
        secondsCount = 0;
      }
      likoriaProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void startLikoriaTimerAgain(LikoriaTimerProvider likoriaProvider, int milliseconds) {
    var timeMap = Utils.timeConverter(Duration(milliseconds: milliseconds));
    secondsCount = timeMap['seconds']!;
    minutesCount = timeMap['minutes']!;
    hoursCount = timeMap['hours']!;
    daysCount = timeMap['days']!;
    likoriaProvider.setDays(daysCount);
    likoriaProvider.setHours(hoursCount);
    likoriaProvider.setMin(minutesCount);
    likoriaProvider.setSec(secondsCount);
    _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp, presetMillisecond: milliseconds);
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
            likoriaProvider.setDays(daysCount);
            hoursCount = 0;
          }
          likoriaProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        likoriaProvider.setMin(minutesCount);
        secondsCount = 0;
      }
      likoriaProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void stopLikoriaTimer(LikoriaTimerProvider likoriaProvider) {
    String tuhurID = likoriaProvider.getID;
    TuhurRecord.uploadTuhurEndTime(tuhurID, daysCount, hoursCount, minutesCount, secondsCount);

    likoriaProvider.setTimerStart(false);
    likoriaProvider.setDays(0);
    likoriaProvider.setHours(0);
    likoriaProvider.setMin(0);
    likoriaProvider.setSec(0);
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

  void resetLikoria(LikoriaTimerProvider likoriaProvider) {
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
    likoriaProvider.resetValue();
  }
}
