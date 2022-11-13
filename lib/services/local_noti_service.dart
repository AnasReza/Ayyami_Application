import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class LocalNotfiService
{
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String sound = 'adhan.mp3';
  Future<void> setup() async {
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = DarwinInitializationSettings(
        requestSoundPermission: true,
    );

    const initSettings =
    InitializationSettings(android: androidSetting, iOS: iosSetting);

    await _localNotificationsPlugin.initialize(initSettings).then((_) {
      print('setupPlugin: setup success');
    }).catchError((Object error) {
      print('Error: $error');
    });
  }

  addNamazNotification(int id,String title,String body,int endTime,{String? channelID,String? channelName})async{
    print(channelName);
    print(endTime);
    print("NOtFI CALLED");
    print(endTime);
    try{
      tzData.initializeTimeZones();
      final scheduleTime =
      tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);
      var soundFile = sound.replaceAll('.mp3', '');
      final notificationSound =
      sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
      final androidDetail = AndroidNotificationDetails(
          channelID!, // channel Id
          channelName!, // channel Name
          playSound: true,
          priority: Priority.high,
          sound: notificationSound
      );
      final iosDetail = sound == ''
          ? null
          : DarwinNotificationDetails(presentSound: true, sound: sound);
      final noticeDetail = NotificationDetails(
        iOS: iosDetail,
        android: androidDetail,
      );
      await _localNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduleTime,
        noticeDetail,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );
    }catch(e){
      print("Errrrrro $e");
    }
  }

  Future<bool> checkIfAlreadyNotification()async{
   var noti = await _localNotificationsPlugin.getActiveNotifications();
   print("notif length ${noti.length}");
   for(var i in noti){
     print("Notificatiojn ${i.id} ${i.title} ${i.channelId}");
   }
    return noti.isEmpty ? true : false;
  }

  addMedicineNotification(int id,String title,String body,int endTime,{String? channelID,String? channelName})async{
    print(title);
    print(endTime);
    tzData.initializeTimeZones();
    final scheduleTime =
    tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);
    // var soundFile = sound.replaceAll('.mp3', '');

    final androidDetail = AndroidNotificationDetails(
        channelID!, // channel Id
        channelName!, // channel Name
        playSound: true,
        priority: Priority.high,

    );
    final iosDetail = sound == ''
        ? null
        : DarwinNotificationDetails(presentSound: true, );
    final noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  cancelNotificationSubscription(){
    _localNotificationsPlugin.cancelAll();
  }
}