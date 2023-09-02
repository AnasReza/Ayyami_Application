import 'package:ayyami/firebase_calls/habit_record.dart';
import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/habit_model.dart';
import '../providers/habit_provider.dart';
import '../tracker/habit_tracker.dart';
import '../tracker/tuhur_tracker.dart';

class QuestionRecord {
  Future<void> uploadQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'question': answer};
    return firestore.update(map);
  }

  Future<void> uploadBeginnerQuestion(
      String uid, String answer, HabitProvider habitProvider) {
    HabitModel habitModel = HabitModel(
        uid: uid,
        habitTuhurDays: 15,
        habitTuhurHours: 0,
        habitTuhurMinutes: 0,
        habitTuhurSeconds: 0,
        habitMensesDays: 3,
        habitMensesHours: 0,
        habitMensesMinutes: 0,
        habitMensesSeconds: 0);
    HabitTracker().updateNewHabitForTest(habitModel, habitProvider);
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'beginner': answer};
    return firestore.update(map);
  }

  Future<void> uploadMarriedQuestion(
      String uid, String answer, HabitProvider habitProvider) {
    HabitModel habitModel = HabitModel(
        uid: uid,
        habitTuhurDays: 15,
        habitTuhurHours: 0,
        habitTuhurMinutes: 0,
        habitTuhurSeconds: 0,
        habitMensesDays: 3,
        habitMensesHours: 0,
        habitMensesMinutes: 0,
        habitMensesSeconds: 0,
        habitLochialDays: 40,
        habitLochialHours: 0,
        habitLochialMinutes: 0,
        habitLochialSeconds: 0);
    HabitTracker().updateNewHabitForTest(habitModel, habitProvider);
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

  // Future<void> uploadStopTimeQuestion(String uid, String answer) {
  //   var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
  //   Map<String, String> map = {'stop_time': answer};
  //   return firestore.update(map);
  // }

  Future<void> uploadMenstrualPeriodQuestion(
      String uid,
      Timestamp startTime,
      Timestamp endTime,
      int days,
      int hours,
      int minutes,
      int seconds,
      TuhurProvider tuhurProvider,
      HabitProvider habitProvider,
      UserProvider userProvider) async {
    if (days < 3) {
      //dont add to firebase invalid blood
      //no change in habit
      // continue last tuhur
      FirebaseFirestore.instance
          .collection('tuhur')
          .where('uid', isEqualTo: userProvider.getUid)
          .orderBy('start_date', descending: true)
          .limit(1)
          .get()
          .then((docs) {
        Timestamp startDate = docs.docs.first.get('start_date');
        FirebaseFirestore.instance
            .collection('tuhur')
            .doc(docs.docs.first.id)
            .update({
          'end_time': FieldValue.delete(),
          'days': FieldValue.delete(),
          'hours': FieldValue.delete(),
          'minutes': FieldValue.delete(),
          'seconds': FieldValue.delete(),
        });
        tuhurProvider.setTimerStart(true);
        tuhurProvider.setFrom(0);
        tuhurProvider.setStartTime(docs.docs.first.get('start_date'));
        tuhurProvider.setTuhurID(docs.docs.first.id);
      });
    } else if (days >= 3 && days <= 10) {
      //update menses start and end, update habit menses, start tuhur
      FirebaseFirestore.instance.collection('menses').add({
        'fromMiscarriageOrDnc': false,
        'start_date': startTime,
        'end_time': endTime,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds,
        'uid': uid
      }).then((value) {
        HabitTracker().getRefreshedHabitDetails(uid).then((habitModel) {
          HabitModel updatedHabit = habitModel!.copyWith(
              habitMensesDays: days,
              habitMensesHours: hours,
              habitLochialMinutes: minutes,
              habitLochialSeconds: seconds);
          HabitRecord().updateMensesHabitDetails(
              uid, updatedHabit.toMensesDurationMap());
          habitProvider.setHabitModel(habitModel);
        });
        tuhurProvider.setTimerStart(true);
        TuhurTracker().startTuhurTimerAfterQuestionaire(
            tuhurProvider, endTime, uid, 0, true);
      });
    } else if (days > 10) {
      FirebaseFirestore.instance.collection('menses').add({
        'start_date': startTime,
        'end_time': Timestamp.fromDate(
            startTime.toDate().add(const Duration(days: 10))),
        'days': 10,
        'hours': 0,
        'minutes': 0,
        'seconds': 0,
        'uid': uid
      }).then((value) {
        HabitTracker().getRefreshedHabitDetails(uid).then((habitModel) {
          HabitModel updatedHabit = habitModel!.copyWith(
              habitMensesDays: 10,
              habitMensesHours: 0,
              habitLochialMinutes: 0,
              habitLochialSeconds: 0);
          HabitRecord().updateMensesHabitDetails(
              uid, updatedHabit.toMensesDurationMap());
          habitProvider.setHabitModel(habitModel);
        });
        tuhurProvider.setTimerStart(true);
        TuhurTracker().startTuhurTimerAfterQuestionaire(
            tuhurProvider,
            Timestamp.fromDate(
                startTime.toDate().add(const Duration(days: 10))),
            uid,
            0,
            true);
      });
    }
  }

  Future<void> uploadMenstrualPeriodQuestionStartDate(
      String uid, Timestamp startTime, MensesProvider mensesProvider) {
    var firestore = FirebaseFirestore.instance.collection('menses');
    return firestore.add({'start_date': startTime, 'uid': uid}).then((value) {
      var diffTillNow = DateTime.now().difference(startTime.toDate());
      print(
          '${diffTillNow.inMilliseconds}   milliseconds from uploadMenstrualPeriodQuestionStartDate');
      // mensesProvider.setTimerStart(true);
      // MensesTracker().startMensisTimerWithTime(mensesProvider, uid, diffTillNow.inMilliseconds,startTime);
    });
  }

  Future<void> uploadPostNatalBleedingQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'post_natal_bleeding': answer};
    return firestore.update(map);
  }

  Future<void> uploadLocation(String uid, String labelText, GeoPoint point) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    return firestore.update({'coordinates': point, 'location_name': labelText});
  }
}
