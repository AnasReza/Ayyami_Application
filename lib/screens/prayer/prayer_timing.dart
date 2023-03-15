import 'dart:async';
import 'dart:ui';

import 'package:adhan/adhan.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/providers/namaz_provider.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/prayer_widget.dart';
// import 'package:background_fetch/background_fetch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../constants/colors.dart';
import '../../translation/app_translation.dart';
import '../../widgets/app_text.dart';
import 'package:timezone/data/latest.dart' as latest;
import 'package:timezone/timezone.dart' as tz;

class PrayerTiming extends StatefulWidget {
  const PrayerTiming({Key? key}) : super(key: key);

  @override
  State<PrayerTiming> createState() => _PrayerTimingState();
}

class _PrayerTimingState extends State<PrayerTiming> {
  String fajr = '', sunrise = '', zuhar = '', asr = '', maghrib = '', isha = '';
  late DateTime fajrTime, sunriseTime, zuharTime, asrTime, maghribTime, ishaTime;
  final _hijriDateToday = HijriCalendar.now();
  static final DateTime _gorgeonDateToday = DateTime.now();
  static final intl.DateFormat _todayDateFormated = intl.DateFormat('dd MMMM yyyy');
  String gorgeonTodayDateFormated = '';
  String hijriDateFormated = '';
  List<DateTime> _events = [];
  int _status = 0;

  // StopWatchTimer timer=StopWatchTimer(mode: StopWatchMode.countUp);
  Timer? timer;
  static Duration duration = Duration();
  final notificationChannelId = 'my_foreground';

// this will be used for notification id, So you can update your custom notification with this id.
  final notificationId = 888;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      hijriDateFormated=_hijriDateToday.toFormat('dd MMMM yyyy');
          gorgeonTodayDateFormated=_todayDateFormated.format(_gorgeonDateToday);
    });
    // initializeService();
    // initPlatformState();
    // BackgroundFetch.start();
  }

  // Future<void> initializeService() async {
  //   final service = FlutterBackgroundService();
  //   AndroidNotificationChannel Androidchannel = AndroidNotificationChannel(
  //     notificationChannelId, // id
  //     'MY FOREGROUND SERVICE', // title
  //     description: 'This channel is used for important notifications.', // description
  //     importance: Importance.low, // importance must be at low or higher level
  //   );
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(Androidchannel);
  //
  //   // await flutterLocalNotificationsPlugin.zo
  //   service
  //       .configure(
  //           androidConfiguration: AndroidConfiguration(
  //             // this will be executed when app is in foreground or background in separated isolate
  //             onStart: onStart,
  //
  //             // auto start service
  //             autoStart: true,
  //             isForegroundMode: true,
  //
  //             // notificationChannelId: notificationChannelId, // this must match with notification channel you created above.
  //             // initialNotificationTitle: 'AWESOME SERVICE',
  //             // initialNotificationContent: 'Initializing',
  //             // foregroundServiceNotificationId: notificationId,
  //           ),
  //           iosConfiguration: IosConfiguration(autoStart: true, onForeground: onStart, onBackground: onIosBackground))
  //       .then((value) {
  //     if (value) {
  //       service.startService();
  //     } else {
  //       print('android not configure');
  //     }
  //   });
  // }
  //
  // @pragma('vm:entry-point')
  // Future<bool> onIosBackground(ServiceInstance service) async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   DartPluginRegistrant.ensureInitialized();
  //
  //   // SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // await preferences.reload();
  //   // final log = preferences.getStringList('log') ?? <String>[];
  //   // log.add(DateTime.now().toIso8601String());
  //   // await preferences.setStringList('log', log);
  //
  //   return true;
  // }
  //
  // static Future<void> onStart(ServiceInstance service) async {
  //   // Only available for flutter 3.0.0 and later
  //   DartPluginRegistrant.ensureInitialized();
  //
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  //   // bring to foreground
  //
  //   startTimer();
  //   // Timer.periodic(const Duration(seconds: 1), (timer) async {
  //   //   if (service is AndroidServiceInstance) {
  //   //     if (await service.isForegroundService()) {
  //   //       flutterLocalNotificationsPlugin.show(
  //   //         notificationId,
  //   //         'COOL SERVICE',
  //   //         'Awesome ${DateTime.now()}',
  //   //         NotificationDetails(
  //   //           android: AndroidNotificationDetails(
  //   //             notificationChannelId,
  //   //             'MY FOREGROUND SERVICE',
  //   //             icon: 'ic_bg_service_small',
  //   //             ongoing: true,
  //   //           ),
  //   //         ),
  //   //       );
  //   //     }
  //   //   }
  //   // });
  // }

  // Future<void> initPlatformState() async {
  //   // Configure BackgroundFetch.
  //   int status = await BackgroundFetch.configure(
  //       BackgroundFetchConfig(
  //           minimumFetchInterval: 15,
  //           forceAlarmManager: false,
  //           stopOnTerminate: false,
  //           startOnBoot: true,
  //           enableHeadless: true,
  //           requiresBatteryNotLow: false,
  //           requiresCharging: false,
  //           requiresStorageNotLow: false,
  //           requiresDeviceIdle: false,
  //           requiredNetworkType: NetworkType.ANY), (String taskId) async {
  //     // <-- Event handler
  //     // This is the fetch-event callback.
  //     print("[BackgroundFetch] Event received $taskId");
  //     setState(() {
  //       _events.insert(0, new DateTime.now());
  //     });
  //     // IMPORTANT:  You must signal completion of your task or the OS can punish your app
  //     // for taking too long in the background.
  //     // BackgroundFetch.finish(taskId);
  //   }, (String taskId) async {
  //     // <-- Task timeout handler.
  //     // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
  //     print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
  //
  //     // BackgroundFetch.finish(taskId);
  //   });
  //   print('[BackgroundFetch] configure success: $status');
  //   setState(() {
  //     _status = status;
  //   });
  //   // timer.secondTime.listen((event) { print(event.toString());});
  //   // timer.onStartTimer();
  //   startTimer();
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   // if (!mounted) return;
  // }

  static void startTimer() {
    var timer = Timer.periodic(Duration(seconds: 1), (timer) => addTime());
  }

  static void addTime() {
    final addSeconds = 1;
    duration = Duration(seconds: duration.inSeconds + addSeconds);
    print('${duration.inSeconds}');
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('uRal9hfUptZmDSnO7S7zXrrx3Ro2')
    //     .update({'example': duration.inSeconds});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NamazProvider>(builder: (consumerContext,provider,child){
      var userProvider=Provider.of<UserProvider>(context,listen: false);
      var darkMode=userProvider.getIsDarkMode;
      var lang=userProvider.getLanguage;
      var text=AppTranslate().textLanguage[lang];

      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: darkMode?AppDarkColors.backgroundGradient:AppColors.backgroundGradient),
        padding: EdgeInsets.only(
          left: 70.w,
          right: 70.w,
          top: 80.h,
          bottom: 30
        ),
        child: SingleChildScrollView(
          child: Directionality(textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr, child: Column(
            children: [

              SizedBox(height: 70.6.h),
              AppText(
                text: text!['prayer_times']!,
                fontSize: 45.sp,
                fontWeight: FontWeight.w700,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppText(
                textAlign: TextAlign.center,
                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                text: "$gorgeonTodayDateFormated\n$hijriDateFormated",
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 50.h,
              ),
              PrayerWidget(
                name: text['fajar']!,
                time: provider.getFajrTime,
                darkMode: darkMode,
              ),
              SizedBox(
                height: 50.h,
              ),
              PrayerWidget(
                name: text['sunrise']!,
                time: provider.getSunriseTime,
                darkMode: darkMode,
              ),
              SizedBox(
                height: 50.h,
              ),
              PrayerWidget(
                name: text['duhur']!,
                time: provider.getDuhurTime,
                darkMode: darkMode,
              ),
              SizedBox(
                height: 50.h,
              ),
              PrayerWidget(
                name: text['asar']!,
                time: provider.getAsrTime,
                darkMode: darkMode,
              ),
              SizedBox(
                height: 50.h,
              ),
              PrayerWidget(
                name: text['maghrib']!,
                time: provider.getMaghribTime,
                darkMode: darkMode,
              ),
              SizedBox(
                height: 50.h,
              ),
              PrayerWidget(
                name: text['isha']!,
                time: provider.getIshaTime,
                darkMode: darkMode,
              ),
            ],
          ),),
        ),
      );
    });
  }
}
