import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as latest;
import 'package:timezone/timezone.dart' as tz;

import '../constants/colors.dart';
import '../providers/namaz_provider.dart';
import '../utils/utils.dart';

class PrayerWidget extends StatefulWidget {
  PrayerWidget(
      {Key? key,
      required this.name,
      required this.time,
      required this.darkMode,
      required this.id,
      required this.show})
      : super(key: key);

  final String name;
  final String time;
  bool darkMode, show;
  int id;

  @override
  State<PrayerWidget> createState() => _PrayerWidgetState();
}

class _PrayerWidgetState extends State<PrayerWidget> {
  bool isClick = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      isClick = widget.show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      return Container(
        width: 558.w,
        height: 104.h,
        decoration: BoxDecoration(
          color: widget.darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
          border: Border.all(
            color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: const [
            BoxShadow(
                color: Color(0x1e1f3d73), offset: Offset(0, 12), blurRadius: 40, spreadRadius: 0)
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            36.w,
            19.h,
            54.w,
            21.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText(
                  text: widget.name,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                ),
              ),
              AppText(
                text: widget.time,
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
              ),
              SizedBox(width: 30.w),
              GestureDetector(
                child: SvgPicture.asset(
                  isClick ? AppImages.bellIcon : AppImages.bellStrikeIcon,
                  height: 20,
                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                ),
                onTap: () {
                  String itemName = '';
                  if (isClick) {
                    isClick = false;
                    cancelNotification(widget.id);
                  } else {
                    isClick = true;
                    reactivatePrayerNotification(widget.id);
                  }
                  switch (widget.id) {
                    case 0:
                      itemName = 'show_fajar';
                      provider.setShowFajar(isClick);
                      break;
                    case 1:
                      itemName = 'show_sunrise';
                      provider.setShowSunrise(isClick);
                      break;
                    case 2:
                      itemName = 'show_duhur';
                      provider.setShowDuhur(isClick);
                      break;
                    case 3:
                      itemName = 'show_asr';
                      provider.setShowAsr(isClick);
                      break;
                    case 4:
                      itemName = 'show_maghrib';
                      provider.setShowMaghrib(isClick);
                      break;
                    case 5:
                      itemName = 'show_isha';
                      provider.setShowIsha(isClick);
                      break;
                  }
                  UsersRecord().updateShowNamaz(provider.getUid, itemName, isClick);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void cancelNotification(int id) {
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
        AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );
    switch (id) {
      case 0:
        Utils.saveAppData(false, 'fajrClick');
        notificationsPlugin.cancel(1);
        break;
      case 1:
        Utils.saveAppData(false, 'sunriseClick');
        notificationsPlugin.cancel(2);
        break;
      case 2:
        Utils.saveAppData(false, 'duhurClick');
        notificationsPlugin.cancel(3);
        break;
      case 3:
        Utils.saveAppData(false, 'asrClick');
        notificationsPlugin.cancel(4);
        break;
      case 4:
        Utils.saveAppData(false, 'maghribClick');
        notificationsPlugin.cancel(5);
        break;
      case 5:
        Utils.saveAppData(false, 'ishaClick');
        notificationsPlugin.cancel(6);
        break;
    }
  }

  void reactivatePrayerNotification(int id) {
    var provider = Provider.of<NamazProvider>(context, listen: false);
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
        AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(
      initializationSettings,
    );
    switch (id) {
      case 0:
        Utils.saveAppData(true, 'fajrClick');
        notificationsPlugin.zonedSchedule(1, 'Fajr', 'Its Fajr time',
            tz.TZDateTime.from(provider.getFajrDateTime, tz.local), platform,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            androidAllowWhileIdle: true,
            matchDateTimeComponents: DateTimeComponents.time);
        break;
      case 1:
        Utils.saveAppData(true, 'sunriseClick');
        notificationsPlugin.zonedSchedule(2, 'Sunrise', 'Its Sunrise time',
            tz.TZDateTime.from(provider.getSunriseDateTime, tz.local), platform,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            androidAllowWhileIdle: true,
            matchDateTimeComponents: DateTimeComponents.time);
        break;
      case 2:
        Utils.saveAppData(true, 'duhurClick');
        notificationsPlugin.zonedSchedule(3, 'Duhur', 'Its Duhur time',
            tz.TZDateTime.from(provider.getDuhurDateTime, tz.local), platform,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            androidAllowWhileIdle: true,
            matchDateTimeComponents: DateTimeComponents.time);
        break;
      case 3:
        Utils.saveAppData(true, 'asrClick');
        notificationsPlugin.zonedSchedule(4, 'Asr', 'Its Asr time',
            tz.TZDateTime.from(provider.getAsrDateTime, tz.local), platform,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            androidAllowWhileIdle: true,
            matchDateTimeComponents: DateTimeComponents.time);
        break;
      case 4:
        Utils.saveAppData(true, 'maghribClick');
        notificationsPlugin.zonedSchedule(5, 'Maghrib', 'Its Maghrib time',
            tz.TZDateTime.from(provider.getMaghribDateTime, tz.local), platform,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            androidAllowWhileIdle: true,
            matchDateTimeComponents: DateTimeComponents.time);
        break;
      case 5:
        Utils.saveAppData(true, 'ishaClick');
        notificationsPlugin.zonedSchedule(6, 'Isha', 'Its Isha time',
            tz.TZDateTime.from(provider.getIshaDateTime, tz.local), platform,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            androidAllowWhileIdle: true,
            matchDateTimeComponents: DateTimeComponents.time);
        break;
    }
  }
}
