import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as latest;
import 'package:timezone/timezone.dart' as tz;
class PrayerNotification{
  void notificationTime(DateTime fajrTime, DateTime sunriseTime, DateTime zuharTime, DateTime asrTime, DateTime maghribTime, DateTime ishaTime) {
    String sound = 'assets/adhan.mp3';
    latest.initializeTimeZones();
    var soundFile = sound.replaceAll('.mp3', '');
    final notificationSound =
    sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
    var android = const AndroidNotificationDetails(
      "1",
      'Prayer Notification',
      importance: Importance.max,
      category: AndroidNotificationCategory.reminder,
    );
    var ios = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );

    notificationsPlugin.zonedSchedule(
        1, 'Fajr', 'Its Fajr time', tz.TZDateTime.from(fajrTime, tz.local), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        2, 'Sunrise', 'Its Sunrise time', tz.TZDateTime.from(sunriseTime, tz.local), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        3, 'Duhur', 'Its Duhur time', tz.TZDateTime.from(zuharTime, tz.local), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        4, 'Asr', 'Its Asr time', tz.TZDateTime.from(asrTime, tz.local), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        5, 'Maghrib', 'Its Maghrib time', tz.TZDateTime.from(maghribTime, tz.local), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        6, 'Isha', 'Its Isha time', tz.TZDateTime.from(ishaTime, tz.local), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }
  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
    print('background click');
  }
  void onDidReceiveLocalNotification(
     NotificationResponse response) async {
    // display a dialog with the notification details, tap ok to go to another page
    print('foreground click');
  }
}