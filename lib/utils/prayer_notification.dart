import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as latest;
import 'package:timezone/timezone.dart' as tz;
class PrayerNotification{
  void notificationTime(DateTime fajrTime, DateTime sunriseTime, DateTime zuharTime, DateTime asrTime, DateTime maghribTime, DateTime ishaTime) {
    latest.initializeTimeZones();

    var android = const AndroidNotificationDetails(
      "1",
      'Prayer Notification',
      importance: Importance.max,

    );
    var ios = DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin?.initialize(
      initializationSettings,
        onDidReceiveNotificationResponse: (response){
        print('onDidReceiveNotificationResponse');
    },onDidReceiveBackgroundNotificationResponse: (response){
      print('onDidReceiveBackgroundNotificationResponse');
    }
    );

    notificationsPlugin.zonedSchedule(
        1, 'Fajr', 'Its Fajr time', tz.TZDateTime.from(fajrTime, tz.local), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        1, 'Fajr', 'Its Fajr time', tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        2, 'Sunrise', 'Its Sunrise time', tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        3, 'Duhur', 'Its Duhur time', tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        4, 'Asr', 'Its Asr time', tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        5, 'Asr', 'Its Maghrib time', tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    notificationsPlugin.zonedSchedule(
        6, 'Asr', 'Its Isha time', tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time).then((value){
          print('isha timings');
    });
  }
}