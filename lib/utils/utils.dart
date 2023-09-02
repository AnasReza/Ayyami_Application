import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../providers/user_provider.dart';

class Utils {
  static Map<String, int> timeConverter(Duration diff) {
    var days = diff.inDays;
    var hours = diff.inHours % 24;
    var minutes = diff.inMinutes % 60;
    var seconds = diff.inSeconds % 60;
    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds
    };
  }

  static Duration toDuration(Map<String, int> diff) {
    return Duration(
        days: diff['days'] ?? 0,
        hours: diff['hours'] ?? 0,
        minutes: diff['minutes'] ?? 0,
        seconds: diff['seconds'] ?? 0);
  }

  static Timestamp addDurationToTimestamp(
      Timestamp timestamp, Map<String, int> durationMap) {
    final dateTime = timestamp.toDate();
    final duration = Duration(
      days: durationMap['days'] ?? 0,
      hours: durationMap['hours'] ?? 0,
      minutes: durationMap['minutes'] ?? 0,
      seconds: durationMap['seconds'] ?? 0,
    );
    final sumDateTime = dateTime.add(duration);
    final sumTimestamp = Timestamp.fromDate(sumDateTime);
    return sumTimestamp;
  }

  Timestamp addTimestamps(Timestamp timestamp1, Timestamp timestamp2) {
    final dateTime1 = timestamp1.toDate();
    final dateTime2 = timestamp2.toDate();
    final sumDateTime = dateTime1.add(dateTime2.difference(DateTime(0, 0, 0)));
    final sumTimestamp = Timestamp.fromDate(sumDateTime);
    return sumTimestamp;
  }
  // // UTC+5: 2023-05-25 04:00:00.000 = PKT: 2023-05-25 09:00:00.00
  // static DateTime convertPktToUtc({required DateTime datetime}) =>
  //     Timestamp.fromMillisecondsSinceEpoch(datetime.millisecondsSinceEpoch)
  //         .toDate()
  //         .toUtc();
  // // convert dateTime to firebase Timestamp
  // static Timestamp toTimestamp(DateTime dateTime) =>
  //     Timestamp.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch);
  // // convert utc back to pkt time
  // static DateTime convertUtcToPkt(Timestamp utcTimestamp) =>
  //     Timestamp.fromMillisecondsSinceEpoch(utcTimestamp.millisecondsSinceEpoch)
  //         .toDate();

  static Map<String, int> timeConverterWithWeeks(Duration diff) {
    // var weeks = 0;
    // var days = diff.inDays;
    // if (days <= 7) {
    //   weeks = days ~/ 7;
    //   days = diff.inDays % 7;
    // }
    // var hours = diff.inHours % 24;
    // var minutes = diff.inMinutes % 60;
    // var seconds = diff.inSeconds % 60;
    int totalSeconds = diff.inSeconds;

    int weeks = totalSeconds ~/ (7 * 24 * 60 * 60);
    int remainingSeconds = totalSeconds % (7 * 24 * 60 * 60);

    int days = remainingSeconds ~/ (24 * 60 * 60);
    remainingSeconds = remainingSeconds % (24 * 60 * 60);

    int hours = remainingSeconds ~/ (60 * 60);
    remainingSeconds = remainingSeconds % (60 * 60);

    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    return {
      'weeks': weeks,
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds
    };
  }

  Map<String, DateTime> assumptionOfMenses(
      UserProvider provider, DateTime startTime) {
    var tuhurTimeMap = provider.getLastTuhurTime;
    var mensesTimeMap = provider.getLastMensesTime;
    Duration tuhurDuration = Duration(
        days: tuhurTimeMap!['days']!, //['day']
        hours: tuhurTimeMap['hours']!,
        minutes: tuhurTimeMap['minutes']!,
        seconds: tuhurTimeMap['seconds']!); //['second']
    Duration mensesDuration = Duration(
        days: mensesTimeMap!['days']!, //['day']
        hours: mensesTimeMap!['hours']!,
        minutes: mensesTimeMap!['minutes']!,
        seconds: mensesTimeMap!['seconds']!); //['second']
    var menses_should_start = startTime.add(tuhurDuration);
    var menses_should_end = menses_should_start.add(mensesDuration);
    return {'start': menses_should_start, 'end': menses_should_end};
  }

  static void saveDocMensesId(String id) async {
    var box = await Hive.openBox('aayami_menses');
    box.put('menses_timer_doc_id', id);
  }

  static dynamic getDocMensesID() async {
    var box = await Hive.openBox('aayami_menses');
    return box.get('menses_timer_doc_id');
  }

  static void saveDocTuhurId(String id) async {
    var box = await Hive.openBox('aayami_tuhur');
    box.put('tuhur_timer_doc_id', id);
  }

  static dynamic getDocTuhurID() async {
    var box = await Hive.openBox('aayami_tuhur');
    return box.get('tuhur_timer_doc_id');
  }

  static void saveDocPostalNatalId(String id) async {
    var box = await Hive.openBox('aayami_post-natal');
    box.put('post-natal_timer_doc_id', id);
  }

  static dynamic getDocPostalNatalID() async {
    var box = await Hive.openBox('aayami_post-natal');
    return box.get('post-natal_timer_doc_id');
  }

  static void saveAppData(dynamic value, String keyName) async {
    print('value==$value  keyName==$keyName');
    var box = await Hive.openBox('aayami');
    box.put(keyName, value);
  }

  static dynamic getAppData(String keyName) async {
    var box = await Hive.openBox('aayami');
    return box.get(keyName);
  }

  static void saveDocLikoriaId(String id) async {
    var box = await Hive.openBox('aayami_likoria');
    box.put('tuhur_timer_doc_id', id);
  }

  static dynamic getDoclikoriaID() async {
    var box = await Hive.openBox('aayami_likoria');
    return box.get('likoria_timer_doc_id');
  }
}
