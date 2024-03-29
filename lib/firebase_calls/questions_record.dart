import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../tracker/menses_tracker.dart';

class QuestionRecord {
  Future<void> uploadQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'question': answer};
    return firestore.update(map);
  }

  Future<void> uploadBeginnerQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'beginner': answer};
    return firestore.update(map);
  }

  Future<void> uploadMarriedQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'married_unmarried': answer};
    return firestore.update(map);
  }

  Future<void> uploadWhichPregnancyQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'which_pregnancy': answer};
    return firestore.update(map);
  }

  Future<void> uploadWhenBleedingStartQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'when_bleeding_start': answer};
    return firestore.update(map);
  }

  Future<void> uploadWhenBleedingStopQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'when_bleeding_stop': answer};
    return firestore.update(map);
  }

  Future<void> uploadBleedingPregnantQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'bleeding_pregnant': answer};
    return firestore.update(map);
  }

  Future<void> uploadArePregnantQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'are_pregnant': answer};
    return firestore.update(map);
  }

  Future<void> uploadWeekPregnantQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'week_pregnant': answer};
    return firestore.update(map);
  }

  Future<void> uploadIsItBleedingQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'is_it_bleeding': answer};
    return firestore.update(map);
  }

  Future<void> uploadStartTimeQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'start_time': answer};
    return firestore.update(map);
  }

  Future<void> uploadStopTimeQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'stop_time': answer};
    return firestore.update(map);
  }

  Future<void> uploadMenstrualPeriodQuestion(String uid, Timestamp startTime, Timestamp endTime,
      int days, int hours, int minutes, int seconds,TuhurProvider tuhurProvider) {
    var firestore = FirebaseFirestore.instance.collection('menses');
    return firestore.add({
      'start_date': startTime,
      'end_time': endTime,
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
      'uid': uid
    }).then((value) {
      var endDate=endTime.toDate();
      var diffTillNow=DateTime.now().difference(endDate);
      // tuhurProvider.setTimerStart(true);
      // TuhurTracker().startTuhurTimerWithSeconds(tuhurProvider, uid, diffTillNow.inMilliseconds,endTime);
    });
  }
  Future<void> uploadMenstrualPeriodQuestionStartDate(String uid, Timestamp startTime,MensesProvider mensesProvider) {
    var firestore = FirebaseFirestore.instance.collection('menses');
    return firestore.add({
      'start_date': startTime,
      'uid': uid
    }).then((value) {
      var diffTillNow=DateTime.now().difference(startTime.toDate());
      print('${diffTillNow.inMilliseconds}   milliseconds from uploadMenstrualPeriodQuestionStartDate');
       // mensesProvider.setTimerStart(true);
       // MensesTracker().startMensisTimerWithTime(mensesProvider, uid, diffTillNow.inMilliseconds,startTime);

    });
  }
  Future<void> uploadPostNatalBleedingQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'post_natal_bleeding': answer};
    return firestore.update(map);
  }
  Future<void> uploadLocation(String uid,String labelText,GeoPoint point) {
    var firestore=FirebaseFirestore.instance.collection('users').doc(uid);
    return firestore.update({'coordinates':point,'location_name':labelText});
  }
}
