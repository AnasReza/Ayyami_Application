import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  String uid;
  //expected habit-start-day of upcoming blood
  // Timestamp habitStartDay;
  //expected habit-end-day of ongoing blood, it should automatically calculate end day to avoid errors
  // Timestamp? habitEndDay;
  //if valid blood has occurred for this month and habit has changed to next month days
  // e.g valid blood occured 1-3 May, after 15 days 18-22 May blood occurs again, it should change habit for April
  // e.g habit start and end was 18 to 21, and blood occurs at 25 again, tho its invalid but it'll check again after,before,At cases
  // this can only be surpassed if we can check invalid tuhur
  // to avoid checking
  // bool hasHabitRecForThisMonth;
  int habitTuhurDays;
  int habitTuhurHours;
  int habitTuhurMinutes;
  int habitTuhurSeconds;
  int habitMensesDays;
  int habitMensesHours;
  int habitMensesMinutes;
  int habitMensesSeconds;
  //habit of exact 40 days is given to beginners
  int? habitLochialDays = 40;
  int? habitLochialHours = 0;
  int? habitLochialMinutes = 0;
  int? habitLochialSeconds = 0;

  HabitModel({
    required this.uid,
    // required this.habitStartDay,
    // this.habitEndDay,
    required this.habitTuhurDays,
    required this.habitTuhurHours,
    required this.habitTuhurMinutes,
    required this.habitTuhurSeconds,
    required this.habitMensesDays,
    required this.habitMensesHours,
    required this.habitMensesMinutes,
    required this.habitMensesSeconds,
    this.habitLochialDays = 40,
    this.habitLochialHours = 0,
    this.habitLochialMinutes = 0,
    this.habitLochialSeconds = 0,
  });
  HabitModel copyWith({
    // Timestamp? habitStartDay,
    // Timestamp? habitEndDay,
    int? habitTuhurDays,
    int? habitTuhurHours,
    int? habitTuhurMinutes,
    int? habitTuhurSeconds,
    int? habitMensesDays,
    int? habitMensesHours,
    int? habitMensesMinutes,
    int? habitMensesSeconds,
    int? habitLochialDays,
    int? habitLochialHours,
    int? habitLochialMinutes,
    int? habitLochialSeconds,
  }) {
    return HabitModel(
      uid: uid,
      // habitStartDay: habitStartDay ?? this.habitStartDay,
      // habitEndDay: habitEndDay ?? this.habitEndDay,
      habitTuhurDays: habitTuhurDays ?? this.habitTuhurDays,
      habitTuhurHours: habitTuhurHours ?? this.habitTuhurHours,
      habitTuhurMinutes: habitTuhurMinutes ?? this.habitTuhurMinutes,
      habitTuhurSeconds: habitTuhurSeconds ?? this.habitTuhurSeconds,
      habitMensesDays: habitMensesDays ?? this.habitMensesDays,
      habitMensesHours: habitMensesHours ?? this.habitMensesHours,
      habitMensesMinutes: habitMensesMinutes ?? this.habitMensesMinutes,
      habitMensesSeconds: habitMensesSeconds ?? this.habitMensesSeconds,
      habitLochialDays: habitLochialDays ?? this.habitLochialDays,
      habitLochialHours: habitLochialHours ?? this.habitLochialHours,
      habitLochialMinutes: habitLochialMinutes ?? this.habitLochialMinutes,
      habitLochialSeconds: habitLochialSeconds ?? this.habitLochialSeconds,
    );
  }

  Map<String, int> toTuhurDurationMap() {
    return {
      'days': habitTuhurDays,
      'hours': habitTuhurHours,
      'minutes': habitTuhurMinutes,
      'seconds': habitTuhurSeconds
    };
  }

  Map<String, int> toLochialDurationMap() {
    return {
      'days': habitLochialDays!,
      'hours': habitLochialHours!,
      'minutes': habitLochialMinutes!,
      'seconds': habitLochialSeconds!
    };
  }

  Map<String, int> toMensesDurationMap() {
    return {
      'days': habitMensesDays,
      'hours': habitMensesHours,
      'minutes': habitMensesMinutes,
      'seconds': habitMensesSeconds
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      // 'habit_start_day': habitStartDay,
      // 'habit_end_day': habitEndDay,
      'habit_tuhur_days': habitTuhurDays,
      'habit_tuhur_hours': habitTuhurHours,
      'habit_tuhur_minutes': habitTuhurMinutes,
      'habit_tuhur_seconds': habitTuhurSeconds,
      'habit_menses_days': habitMensesDays,
      'habit_menses_hours': habitMensesHours,
      'habit_menses_minutes': habitMensesMinutes,
      'habit_menses_seconds': habitMensesSeconds,
      'habit_lochial_days': habitLochialDays,
      'habit_lochial_hours': habitLochialHours,
      'habit_lochial_minutes': habitLochialMinutes,
      'habit_lochial_seconds': habitLochialSeconds,
    };
  }

  static HabitModel fromMap(Map<String, dynamic> map) {
    return HabitModel(
      uid: map['uid'],
      // habitStartDay: map['habit_start_day'],
      // habitEndDay: map['habit_end_day'],
      habitTuhurDays: map['habit_tuhur_days'],
      habitTuhurHours: map['habit_tuhur_hours'],
      habitTuhurMinutes: map['habit_tuhur_minutes'],
      habitTuhurSeconds: map['habit_tuhur_seconds'],
      habitMensesDays: map['habit_menses_days'],
      habitMensesHours: map['habit_menses_hours'],
      habitMensesMinutes: map['habit_menses_minutes'],
      habitMensesSeconds: map['habit_menses_seconds'],
      habitLochialDays: map['habit_locial_days'],
      habitLochialHours: map['habit_locial_hours'],
      habitLochialMinutes: map['habit_locial_minutes'],
      habitLochialSeconds: map['habit_locial_seconds'],
    );
  }

  factory HabitModel.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();
    return HabitModel(
      uid: data['uid'],
      // habitStartDay: data['habit_start_day'],
      // habitEndDay: data['habit_end_day'],
      habitTuhurDays: data['habit_tuhur_days'],
      habitTuhurHours: data['habit_tuhur_hours'],
      habitTuhurMinutes: data['habit_tuhur_minutes'],
      habitTuhurSeconds: data['habit_tuhur_seconds'],
      habitMensesDays: data['habit_menses_days'],
      habitMensesHours: data['habit_menses_hours'],
      habitMensesMinutes: data['habit_menses_minutes'],
      habitMensesSeconds: data['habit_menses_seconds'],
      habitLochialDays: data['habit_locial_days'],
      habitLochialHours: data['habit_locial_hours'],
      habitLochialMinutes: data['habit_locial_minutes'],
      habitLochialSeconds: data['habit_locial_seconds'],
    );
  }
}
