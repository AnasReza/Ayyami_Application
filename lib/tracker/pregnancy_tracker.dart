import 'package:ayyami/firebase_calls/pregnancy_record.dart';
import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../providers/pregnancy_timer_provider.dart';

class PregnancyTracker {
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;
  int weekCount = 0;

  final TuhurTracker tuhurTracker = TuhurTracker();
  final MensesTracker mensesTracker = MensesTracker();
   late StopWatchTimer _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startPregnancyTimer(UserProvider userProvider, PregnancyProvider provider, String uid,
      TuhurProvider tuhurProvider, Timestamp startTime) {
    if (tuhurProvider.getTimerStart) {
      tuhurTracker.stopTuhurTimer(tuhurProvider,startTime);
      var pregnancy = PregnancyRecord().uploadPregnancyStart(uid, startTime);
      pregnancy.then((value) {
        saveDocId(value.id);
        provider.setPregnancyID(value.id);
        provider.setTimerStart(true);
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
              if (daysCount > 7) {
                daysCount = 0;
                weekCount++;
                provider.setWeeks(weekCount);
              }
              provider.setDays(daysCount);
              hoursCount = 0;
            }
            provider.setHours(hoursCount);
            minutesCount = 0;
          }
          // else if (minutesCount == 10) {
          //   stopMensesTimer(mensesProvider, tuhurProvider, uid);
          // }

          provider.setMin(minutesCount);
          secondsCount = 0;
        }

        provider.setSec(secondsCount);
      });
      _stopWatch.onStartTimer();
    } else {
      toast_notification().toast_message('impossible_pregnancy'.tr);
    }
  }

  void stopPregnancyTimer(PregnancyProvider provider, Timestamp endTime,String reason) {
    var pID = getDocID();
    PregnancyRecord().uploadPregnancyEndTime(endTime, pID,reason);
  }

  void startPregnancyAgain(PregnancyProvider provider, int milliseconds) {
    var timeMap=Utils.timeConverterWithWeeks(Duration(milliseconds: milliseconds));
    weekCount=timeMap['weeks']!;
    daysCount=timeMap['days']!;
    hoursCount=timeMap['hours']!;
    minutesCount=timeMap['minutes']!;
    secondsCount=timeMap['seconds']!;
    provider.setWeeks(weekCount);
    provider.setDays(daysCount);
    provider.setHours(hoursCount);
    provider.setMin(minutesCount);
    provider.setSec(secondsCount);
    _stopWatch=StopWatchTimer(mode: StopWatchMode.countUp,);
    _stopWatch.secondTime.listen((event) {
      print('$secondsCount==sec    $minutesCount==minutes');
      secondsCount++;
      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
            if (daysCount > 7) {
              daysCount = 0;
              weekCount++;
              provider.setWeeks(weekCount);
            }
            provider.setDays(daysCount);
            hoursCount = 0;
          }
          provider.setHours(hoursCount);
          minutesCount = 0;
        }
        // else if (minutesCount == 10) {
        //   stopMensesTimer(mensesProvider, tuhurProvider, uid);
        // }

        provider.setMin(minutesCount);
        secondsCount = 0;
      }

      provider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  static void saveDocId(String id) async {
    var box = await Hive.openBox('aayami_pregnancy');
    box.put('pregnancy_timer_doc_id', id);
  }

  dynamic getDocID() async {
    var box = await Hive.openBox('aayami_pregnancy');
    return box.get('pregnancy_timer_doc_id');
  }
}
