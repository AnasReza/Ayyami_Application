import 'package:ayyami/providers/medicine_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as latest;
import 'package:timezone/timezone.dart' as tz;

class SendNotification {
  void prayerNotificationTime(DateTime fajrTime, DateTime sunriseTime, DateTime zuharTime,
      DateTime asrTime, DateTime maghribTime, DateTime ishaTime, UserProvider provider) {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound = sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "1",
      'Prayer Notification',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );
    if (provider.getShowFajar) {
      notificationsPlugin.zonedSchedule(
          1, 'Fajr', 'Its Fajr time', tz.TZDateTime.from(fajrTime, tz.local), platform,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.time);
    }
    if (provider.getShowSunrise) {
      notificationsPlugin.zonedSchedule(
          2, 'Sunrise', 'Its Sunrise time', tz.TZDateTime.from(sunriseTime, tz.local), platform,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.time);
    }
    if (provider.getShowDuhur) {
      notificationsPlugin.zonedSchedule(
          3, 'Duhur', 'Its Duhur time', tz.TZDateTime.from(zuharTime, tz.local), platform,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.time);
    }

    if (provider.getShowAsr) {
      notificationsPlugin.zonedSchedule(
          4, 'Asr', 'Its Asr time', tz.TZDateTime.from(asrTime, tz.local), platform,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.time);
    }

    if (provider.getShowMaghrib) {
      notificationsPlugin.zonedSchedule(
          5, 'Maghrib', 'Its Maghrib time', tz.TZDateTime.from(maghribTime, tz.local), platform,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.time);
    }
    if (provider.getShowIsha) {
      notificationsPlugin.zonedSchedule(
          6, 'Isha', 'Its Isha time', tz.TZDateTime.from(ishaTime, tz.local), platform,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.time);
    }
  }

  void medicineNotificationTime(
      List<Map<String, dynamic>> medList, String medName, MedicineProvider provider) {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound = sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "2",
      'Medicine Reminder',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );

    var mapList = provider.getMap;

    for (int x = 0; x < medList.length; x++) {
      Timestamp timestamp = medList[x]['time'];
      int notiId = medList[x]['notificationID'];
      notificationsPlugin.periodicallyShow(
        notiId,
        'Medicine Reminder',
        'You should eat $medName',
        RepeatInterval.daily,
        platform,
        androidAllowWhileIdle: true,
      );
      notificationsPlugin.zonedSchedule(
        7,
        '',
        '',
        tz.TZDateTime.from(timestamp.toDate(), tz.local),
        platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  void cancelMedicineNotification(List<Map<String, dynamic>> medList, MedicineProvider provider) {
    var android = const AndroidNotificationDetails(
      "2",
      'Medicine Reminder',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );
    var mapList = provider.getMap;
    for (int x = 0; x < medList.length; x++) {
      int notiId = medList[x]['notificationID'];
      notificationsPlugin.cancel(
        notiId,
      );
    }
  }

  void medicineEditNotificationTime(
      int index, List<Map<String, dynamic>> medList, String medName, MedicineProvider provider) {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound = sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "2",
      'Medicine Reminder',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );
    var mapList = provider.getMap;
    for (int x = 0; x < medList.length; x++) {
      Timestamp timestamp = medList[x]['time'];
      notificationsPlugin.periodicallyShow(
        index + x + 7,
        'Medicine Reminder',
        'You should eat $medName',
        RepeatInterval.daily,
        platform,
        androidAllowWhileIdle: true,
      );
      notificationsPlugin.zonedSchedule(
        7,
        '',
        '',
        tz.TZDateTime.from(timestamp.toDate(), tz.local),
        platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  void sadqaNotificationTime(int sadqaAmount) {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound = sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "3",
      'Sadqa reminder',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );

    notificationsPlugin.periodicallyShow(
      50,
      'Sadqa reminder',
      'You should pay \$$sadqaAmount',
      RepeatInterval.daily,
      platform,
      androidAllowWhileIdle: true,
    );
    notificationsPlugin.zonedSchedule(
      50,
      '',
      '',
      tz.TZDateTime.from(DateTime(2023, 1, 1, 7, 0), tz.local),
      platform,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  void cancelSadqaNotificationTime() {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound = sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "3",
      'Sadqa reminder',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );

    notificationsPlugin.cancel(50);
  }

  void cycleNotificationTime(DateTime datetime) {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound = sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "3",
      'Sadqa reminder',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );

    var format = DateFormat('dd-MM-yyyy');
    var date = format.format(datetime);
    var beforeDate = datetime.subtract(const Duration(days: 7));

    notificationsPlugin.zonedSchedule(
      500,
      'Cycle Reminder',
      'Your Menses should start at: $date',
      tz.TZDateTime.from(beforeDate, tz.local),
      platform,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  void cancelCycleNotificationTime() {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound = sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "3",
      'Sadqa reminder',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );

    notificationsPlugin.cancel(500);
  }

  void cancelAll() {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound = sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "3",
      'Sadqa reminder',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );

    notificationsPlugin.cancelAll();
  }
}
