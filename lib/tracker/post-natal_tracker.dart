import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/models/habit_model.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../firebase_calls/habit_record.dart';
import '../firebase_calls/post-natal_record.dart';
import '../providers/habit_provider.dart';
import '../providers/tuhur_provider.dart';
import '../providers/user_provider.dart';
import '../utils/utils.dart';

class PostNatalTracker {
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  late var _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startPostNatalTimer(UserProvider userProvider, int pregnancyCount,
      Timestamp startTime, PostNatalProvider postNatalProvider) {
    pregnancyCount = pregnancyCount == 0 ? 1 : pregnancyCount;
    Future<DocumentReference<Map<String, dynamic>>> tuhur = PostNatalRecord()
        .uploadPostNatalStartTime(
            userProvider.getUid, pregnancyCount, startTime);
    UsersRecord().updateUserPostNatalStatus(userProvider.getUid, true); 
    userProvider.setbleedingPregnant(true);
    // to avoid duplicate timers
    // postNatalProvider.resetStopWatchTimer();
    // _stopWatch.onStopTimer();
    // _stopWatch.onResetTimer();

    // tuhur.then((value) {
    //   saveDocId(value.id);
    //   postNatalProvider.setPostNatalID(value.id);
    //   postNatalProvider.setPregnancyCount(pregnancyCount);
    //   postNatalProvider.setStartTime(startTime);
    //   postNatalProvider.setTimerStart(true);
    //   print('${value.id} post-natal doc id');
    // });
    // _stopWatch.secondTime.listen((event) {
    //   print('startPostNatal: $secondsCount==sec    $minutesCount==minutes');
    //   secondsCount++;
    //   if (secondsCount > 59) {
    //     minutesCount++;
    //     if (minutesCount > 59) {
    //       hoursCount++;
    //       if (hoursCount > 23) {
    //         daysCount++;
    //         // if (daysCount > 30) {
    //         //   daysCount = 0;
    //         // }
    //         postNatalProvider.setDays(daysCount);
    //         hoursCount = 0;
    //       }
    //       postNatalProvider.setHours(hoursCount);
    //       minutesCount = 0;
    //     }
    //     postNatalProvider.setMin(minutesCount);
    //     secondsCount = 0;
    //   }
    //   postNatalProvider.setSec(secondsCount);
    // });
    // _stopWatch.onStartTimer();
  }

  void startPostNatalAgain(
      PostNatalProvider provider,UserProvider userProvider, Timestamp startTime, int milliseconds) {
    UsersRecord().updateUserPostNatalStatus(userProvider.getUid, true);
    userProvider.setbleedingPregnant(true);

    var timeMap = Utils.timeConverter(Duration(milliseconds: milliseconds));
    daysCount = timeMap['days']!;
    hoursCount = timeMap['hours']!;
    minutesCount = timeMap['minutes']!;
    secondsCount = timeMap['seconds']!;

    provider.resetStopWatchTimer();
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();

    provider.setStartTime(startTime);
    provider.setTimerStart(true);
    provider.setDays(daysCount);
    provider.setHours(hoursCount);
    provider.setMin(minutesCount);
    provider.setSec(secondsCount);
    _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);
    _stopWatch.secondTime.listen((event) {
      print(
          'startPostNatalAgain: $secondsCount==sec    $minutesCount==minutes');
      secondsCount++;
      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
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

  void continueLastPostNatalTimer(String docId,
      Timestamp currentPostNatalStartTime, PostNatalProvider provider, UserProvider userProvider) {
    PostNatalRecord().deletePostNatalEndTime(docId);
    UsersRecord().updateUserPostNatalStatus(userProvider.getUid, true); 
    userProvider.setbleedingPregnant(true);
    // chane in doc will trigger home listen event and will start postnatal timer again function
    //  provider.resetStopWatchTimer();
    // _stopWatch.onStopTimer();
    // _stopWatch.onResetTimer();
    // provider.setStartTime(currentPostNatalStartTime);
    // provider.setTimerStart(true);
    // provider.setDays(daysCount);
    // provider.setHours(hoursCount);
    // provider.setMin(minutesCount);
    // provider.setSec(secondsCount);
    // _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);
    // _stopWatch.secondTime.listen((event) {
    //   print(
    //       'startPostNatalAgain: $secondsCount==sec    $minutesCount==minutes');
    //   secondsCount++;
    //   if (secondsCount > 59) {
    //     minutesCount++;
    //     if (minutesCount > 59) {
    //       hoursCount++;
    //       if (hoursCount > 23) {
    //         daysCount++;
    //         provider.setDays(daysCount);
    //         hoursCount = 0;
    //       }
    //       provider.setHours(hoursCount);
    //       minutesCount = 0;
    //     }
    //     // else if (minutesCount == 10) {
    //     //   processStopMensesTimer(mensesProvider, tuhurProvider, uid);
    //     // }

    //     provider.setMin(minutesCount);
    //     secondsCount = 0;
    //   }

    //   provider.setSec(secondsCount);
    // });
    // _stopWatch.onStartTimer();
  }

  void stopPostNatalTimer(
      UserProvider userProvider,
      Timestamp endTime,
      PostNatalProvider postNatalProvider,
      HabitProvider habitProvider,
      TuhurProvider tuhurProvider) {
    var postNatalDiff =
        endTime.toDate().difference(postNatalProvider.getStartTime.toDate());
    var map = Utils.timeConverter(postNatalDiff);
    int days = map['days']!;
    int hours = map['hours']!;
    int minutes = map['minutes']!;
    int seconds = map['seconds']!;
    int maxPostNatalDays = 40;
    //if days are <= 40; update postnatal-end; update habit lochial days;
    if (postNatalDiff.inDays <= maxPostNatalDays) {
      PostNatalRecord().updatePostNatalEndtime(postNatalProvider.getpostNatalID,
          endTime, days, hours, minutes, seconds);
      UsersRecord().updateUserPostNatalStatus(userProvider.getUid, false);
      userProvider.setbleedingPregnant(false);

      HabitModel habitModel = habitProvider.habitModel.copyWith(
          habitLochialDays: days,
          habitLochialHours: hours,
          habitLochialMinutes: minutes,
          habitLochialSeconds: seconds);
      HabitRecord().updateHabitDetails(habitModel);
      habitProvider.setHabitModel(habitModel);

      TuhurTracker().startTuhurTimer(
          tuhurProvider, userProvider.getUid, 1, false, endTime);
    } else // if days are > 40, make it to max 40
    {
      var maxEndTime =
          postNatalProvider.getStartTime.toDate().add(const Duration(days: 40));
      PostNatalRecord().updatePostNatalEndtime(postNatalProvider.getpostNatalID,
          Timestamp.fromDate(maxEndTime), 40, 0, 0, 0);
      UsersRecord().updateUserPostNatalStatus(userProvider.getUid, false);
      userProvider.setbleedingPregnant(false);

      HabitModel habitModel = habitProvider.habitModel.copyWith(
          habitLochialDays: 40,
          habitLochialHours: 0,
          habitLochialMinutes: 0,
          habitLochialSeconds: 0);
      HabitRecord().updateHabitDetails(habitModel);
      habitProvider.setHabitModel(habitModel);

      TuhurTracker().startTuhurTimer(tuhurProvider, userProvider.getUid, 1,
          false, Timestamp.fromDate(maxEndTime));
    }
    postNatalProvider.resetValue();
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  void resetTracker(PostNatalProvider provider) {
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
    provider.resetValue();
  }

  dynamic getDocID() async {
    var box = await Hive.openBox('aayami_post-natal');
    return box.get('post-natal_timer_doc_id');
  }

  dynamic saveDocId(String docID) async {
    var box = await Hive.openBox('aayami_post-natal');
    return box.get('post-natal_timer_doc_id');
  }
}
