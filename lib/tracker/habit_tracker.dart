import 'package:ayyami/firebase_calls/habit_record.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/habit_model.dart';
import '../providers/habit_provider.dart';
import '../providers/user_provider.dart';

class HabitTracker {
  updateOnlyMensisHabit(
      DateTime currentMensesStartDay,
      DateTime currentMensesEndDay,
      UserProvider userProvider,
      HabitProvider habitProvider) {
    Duration currentMensesDuration =
        currentMensesEndDay.difference(currentMensesStartDay);
    Map<String, int> currentMensesDurationMap =
        Utils.timeConverter(currentMensesDuration);
    HabitModel habitModel = habitProvider.habitModel.copyWith(
        habitMensesDays: currentMensesDurationMap['days'] ?? 0,
        habitMensesHours: currentMensesDurationMap['hours'] ?? 0,
        habitMensesMinutes: currentMensesDurationMap['minutes'] ?? 0,
        habitMensesSeconds: currentMensesDurationMap['seconds'] ?? 0);
    var status = HabitRecord().updateHabitDetails(habitModel);
    print(habitProvider);
    habitProvider.setHabitModel(habitModel);
    status.then((s) {
      print("habitModel has updated only menses details with status $s");
    });
  }

  updateNewHabit(
      Timestamp lastMensesEndDay,
      DateTime currentMensesStartDay,
      DateTime currentMensesEndDay,
      UserProvider userProvider,
      HabitProvider habitProvider) {
    Duration curentTuhurDuration =
        currentMensesStartDay.difference(lastMensesEndDay.toDate());
    Map<String, int> curentTuhurDurationMap =
        Utils.timeConverter(curentTuhurDuration);
    Duration currentMensesDuration =
        currentMensesEndDay.difference(currentMensesStartDay);
    Map<String, int> currentMensesDurationMap =
        Utils.timeConverter(currentMensesDuration);
    HabitModel habitModel = HabitModel(
        uid: userProvider.getUid,
        habitTuhurDays: curentTuhurDurationMap['days'] ?? 0,
        habitTuhurHours: curentTuhurDurationMap['hours'] ?? 0,
        habitTuhurMinutes: curentTuhurDurationMap['minutes'] ?? 0,
        habitTuhurSeconds: curentTuhurDurationMap['seconds'] ?? 0,
        habitMensesDays: currentMensesDurationMap['days'] ?? 0,
        habitMensesHours: currentMensesDurationMap['hours'] ?? 0,
        habitMensesMinutes: currentMensesDurationMap['minutes'] ?? 0,
        habitMensesSeconds: currentMensesDurationMap['seconds'] ?? 0);
    var status = HabitRecord().updateHabitDetails(habitModel);
    print(habitProvider);
    habitProvider.setHabitModel(habitModel);
    status.then((s) {
      print("habitModel is updated with status $s");
    });
  }

  updateNewHabitForTest(HabitModel habitModel, HabitProvider habitProvider) {
    // if valid blood days and difference bw start and end ==  count
    // assert(habitModel.habitDays > 3 && habitModel.habitDays <= 10);
    Map<String, int> durationTuhurMap = Utils.timeConverter(Duration(
        days: habitModel.habitTuhurDays,
        hours: habitModel.habitTuhurHours,
        minutes: habitModel.habitTuhurMinutes,
        seconds: habitModel.habitTuhurSeconds));
    // Timestamp endDay =
    //     Utils.addDurationToTimestamp(habitModel., durationMap);
    var status = HabitRecord().updateHabitDetails(habitModel);
    print(habitProvider);
    habitProvider.setHabitModel(habitModel);
    HabitModel prov = habitProvider.habitModel;
    print(habitProvider.habitModel);
    status.then((s) {
      print("habitModel is updated with status $s");
    });
  }

  Future<HabitModel?> getRefreshedHabitDetails(String uid) async {
    HabitModel? habitModel;
    final stream = HabitRecord().getHabitDetails(uid).take(1);
    final snapshot = await stream.first;

    if (snapshot.docs.isNotEmpty) {
      final documentSnapshot = snapshot.docs.first;
      habitModel = HabitModel.fromDocumentSnapshot(documentSnapshot);
    }
    return habitModel;
  }

  Map<String, int>? getTuhurHabitDetails(String userId) {
    HabitModel? habitModel;
    HabitRecord().getHabitDetails(userId).listen((event) {
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          event.docs.first;
      if (documentSnapshot.exists) {
        habitModel = HabitModel.fromDocumentSnapshot(documentSnapshot);
      }
    });
    return habitModel != null ? habitModel!.toTuhurDurationMap() : null;
  }

  Map<String, int>? getMensesHabitDetails(String userId) {
    HabitModel? habitModel;
    HabitRecord().getHabitDetails(userId).listen((event) {
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          event.docs.first;
      if (documentSnapshot.exists) {
        habitModel = HabitModel.fromDocumentSnapshot(documentSnapshot);
      }
    });
    return habitModel != null ? habitModel!.toMensesDurationMap() : null;
  }
}
