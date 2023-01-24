import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../firebase_calls/post-natal_record.dart';
import '../utils/utils.dart';

class PostNatalTracker{
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  late var _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startPostNatalTimer(String uid,PostNatalProvider postNatalProvider){
    Future<DocumentReference<Map<String, dynamic>>> tuhur = PostNatalRecord().uploadPostNatalStartTime(uid);
    tuhur.then((value) {
      saveDocId(value.id);

      postNatalProvider.setPostNatalID(value.id);
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
            postNatalProvider.setDays(daysCount);
            hoursCount = 0;
          }
          postNatalProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        postNatalProvider.setMin(minutesCount);
        secondsCount = 0;
      }
      postNatalProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }
  void startPostNatalAgain(PostNatalProvider provider, int milliseconds) {
    var timeMap=Utils.timeConverterWithWeeks(Duration(milliseconds: milliseconds));
    daysCount=timeMap['days']!;
    hoursCount=timeMap['hours']!;
    minutesCount=timeMap['minutes']!;
    secondsCount=timeMap['seconds']!;
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
  dynamic getDocID() async {
    var box = await Hive.openBox('aayami_post-natal');
    return box.get('post-natal_timer_doc_id');
  }
  dynamic saveDocId(String docID) async {
    var box = await Hive.openBox('aayami_post-natal');
    return box.get('post-natal_timer_doc_id');
  }
}