// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';

import '../models/habit_model.dart';

class HabitProvider extends ChangeNotifier {
  late HabitModel habitModel;
  // late int habit_count_days;
  // late Timestamp habit_start_day;
  // late Timestamp habit_end_day;

  // HabitModel get gethabitModel => habitModel;
  // int get getHabitCountDays => habit_count_days;
  // Timestamp get getHabitStartDay => habit_start_day;
  // Timestamp get getHabitEndDay => habit_end_day;

  void setHabitModel(HabitModel habitModel) {
    this.habitModel = habitModel;
    print("habit model set to $habitModel");
    notifyListeners();
  }

  // void setHabitCountDays(int mhabitCountDays) {
  //   habit_count_days = mhabitCountDays;
  //   notifyListeners();
  // }

  // void setHabitStartDay(Timestamp habitStartDay) {
  //   habitStartDay = habitStartDay;
  //   notifyListeners();
  // }

  // void setHabitEndDay(Timestamp habitEndDay) {
  //   habitEndDay = habitEndDay;
  //   notifyListeners();
  // }
}
