import 'package:ayyami/firebase_calls/pregnancy_record.dart';
import 'package:ayyami/firebase_calls/user_record.dart';
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
import '../translation/app_translation.dart';

class PregnancyTracker {
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;
  int weekCount = 0;

  final TuhurTracker tuhurTracker = TuhurTracker();
  final MensesTracker mensesTracker = MensesTracker();
  late StopWatchTimer _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startPregnancyTimer(
    UserProvider userProvider,
    PregnancyProvider provider,
    String uid,
    TuhurProvider tuhurProvider,
    Timestamp startTime,
  ) {
    if (tuhurProvider.getTimerStart) {
      tuhurTracker.stopTuhurTimer(tuhurProvider, startTime);
      var pregnancy = PregnancyRecord().uploadPregnancyStart(
          uid, userProvider.allPregnancyData.length, startTime);
      UsersRecord().updateUserPregnancyStatus(uid, true);
      userProvider.setArePregnant(true);
      pregnancy.then((docId) {
        saveDocId(docId);
        provider.setPregnancyID(docId);
        provider.setTimerStart(true);
      });
      _stopWatch.secondTime.listen((event) {
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
          //   processStopMensesTimer(mensesProvider, tuhurProvider, uid);
          // }

          provider.setMin(minutesCount);
          secondsCount = 0;
        }

        provider.setSec(secondsCount);
      });
      _stopWatch.onStartTimer();
    } else {
      var lang = userProvider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      toast_notification().toast_message(text!['impossible_pregnancy']!);
    }
  }

  void stopPregnancyTimer(UserProvider userProvider,
      PregnancyProvider pregnancyProvider, Timestamp endTime, String reason) {
    PregnancyRecord()
        .uploadPregnancyEndTime(endTime, pregnancyProvider.pregnancyID, reason);
    UsersRecord().updateUserPregnancyStatus(userProvider.getUid, false);
    userProvider.setArePregnant(false);
    resetValue(pregnancyProvider);
  }

  void startPregnancyAgain(PregnancyProvider provider, int milliseconds) {
    var timeMap =
        Utils.timeConverterWithWeeks(Duration(milliseconds: milliseconds));

    weekCount = timeMap['weeks']!;
    daysCount = timeMap['days']!;
    hoursCount = timeMap['hours']!;
    minutesCount = timeMap['minutes']!;
    secondsCount = timeMap['seconds']!;

    provider.setWeeks(weekCount);
    provider.setDays(daysCount);
    provider.setHours(hoursCount);
    provider.setMin(minutesCount);
    provider.setSec(secondsCount);
    _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);
    _stopWatch.secondTime.listen((event) {
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
        //   processStopMensesTimer(mensesProvider, tuhurProvider, uid);
        // }

        provider.setMin(minutesCount);
        secondsCount = 0;
      }
      provider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void resetValue(PregnancyProvider provider) {
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
    provider.resetValue();
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
