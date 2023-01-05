import 'package:adhan/adhan.dart';
import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/screens/prayer/prayer_timing.dart';
import 'package:ayyami/screens/profile/profile.dart';
import 'package:ayyami/screens/settings/settings.dart';
import 'package:ayyami/screens/supplications/supplications.dart';
import 'package:ayyami/widgets/side_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/images.dart';
import '../navigation/custom_bottom_nav.dart';
import '../navigation/custom_fab.dart';
import '../providers/namaz_provider.dart';
import '../providers/user_provider.dart';
import 'home/home.dart';
import 'package:timezone/data/latest.dart' as latest;
import 'package:timezone/timezone.dart' as tz;

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  final int _cIndex = 0;
  int widgetIndex = 2;
  List<Widget> widgetList = [ProfilePage(), Supplications(), HomeScreen(), PrayerTiming(), SettingsApp()];
  final GlobalKey<ScaffoldState> _key=GlobalKey();
  String fajr = '', sunrise = '', zuhar = '', asr = '', maghrib = '', isha = '';
  late DateTime fajrTime, sunriseTime, zuharTime, asrTime, maghribTime, ishaTime;
  final _hijriDateToday = HijriCalendar.now();
  static final DateTime _gorgeonDateToday = DateTime.now();
  static final DateFormat _todayDateFormated = DateFormat('dd MMMM yyyy');
  String gorgeonTodayDateFormated = '';
  String hijriDateFormated = '';
  List<DateTime> _events = [];
  int _status = 0;

@override
  void initState() {
    // TODO: implement initState
    getPrayerTiming();
  }
  void getPrayerTiming() {
    var userProvider = context.read<UserProvider>();
    var prayerProvider = context.read<NamazProvider>();
    var currentPoints = userProvider.getCurrentPoint;
    final coordinates = Coordinates(currentPoints.latitude, currentPoints.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(coordinates, params);
    print('${prayerTimes.currentPrayer()} current prayer');
    print('${prayerTimes.nextPrayer()} next prayer');
    print("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
    Map<String, DateTime> prayerMap = {};
    prayerMap['fajr'] = prayerTimes.fajr;
    prayerMap['sunrise'] = prayerTimes.sunrise;
    prayerMap['dhuhr'] = prayerTimes.dhuhr;
    prayerMap['asr'] = prayerTimes.asr;
    prayerMap['maghrib'] = prayerTimes.maghrib;
    prayerMap['isha'] = prayerTimes.isha;

    fajrTime = prayerTimes.fajr;
    sunriseTime = prayerTimes.sunrise;
    zuharTime = prayerTimes.dhuhr;
    asrTime = prayerTimes.asr;
    maghribTime = prayerTimes.maghrib;
    ishaTime = prayerTimes.isha;

    prayerProvider.setFajrTime(DateFormat.jm().format(prayerTimes.fajr));
    prayerProvider.setSunriseTime(DateFormat.jm().format(prayerTimes.sunrise));
    prayerProvider.setDuhurTime(DateFormat.jm().format(prayerTimes.dhuhr));
    prayerProvider.setAsrTime(DateFormat.jm().format(prayerTimes.asr));
    prayerProvider.setMaghribTime(DateFormat.jm().format(prayerTimes.maghrib));
    prayerProvider.setIshaTime(DateFormat.jm().format(prayerTimes.isha));
    notificationTime();

    print(DateFormat.jm().format(prayerTimes.fajr));
    print(DateFormat.jm().format(prayerTimes.sunrise));
    print(DateFormat.jm().format(prayerTimes.dhuhr));
    print(DateFormat.jm().format(prayerTimes.asr));
    print(DateFormat.jm().format(prayerTimes.maghrib));
    print(DateFormat.jm().format(prayerTimes.isha));
  }

  void getPrayerTimeBackground() {}

  void notificationTime() {
    latest.initializeTimeZones();

    var android = const AndroidNotificationDetails(
      "1",
      'ZonedExample',
      importance: Importance.max,
    );
    var ios = DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    notificationsPlugin.initialize(initializationSettings);
    notificationsPlugin
        .zonedSchedule(
        1, 'Zoned Example', 'Zoned Example Body', tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)), platform,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time)
        .then((value) {
      FirebaseAuth auth = FirebaseAuth.instance;
      String? uid = auth.currentUser?.uid!;
      FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
        print('${value.get('location_name')} location name from firebase');
      });
    }).whenComplete((){
      FirebaseAuth auth = FirebaseAuth.instance;
      String? uid = auth.currentUser?.uid!;
      FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
        print('${value.get('location_name')} location name from firebase when complete');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(padding: EdgeInsets.only(left: 10),child: InkWell(
          onTap: () {
            _key.currentState!.openDrawer();
            // Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTiming()));
          },
          child: SvgPicture.asset(
            AppImages.menuIcon,
            width: 44.w,
            height: 38.h,
          ),
        ),),
        leadingWidth: 30,
        title: SvgPicture.asset(
          AppImages.logo,
          width: 249.6.w,
          height: 78.36.h,
        ),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       _key.currentState!.openDrawer();
        //       // Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTiming()));
        //     },
        //     child: SvgPicture.asset(
        //       AppImages.menuIcon,
        //       width: 44.w,
        //       height: 38.h,
        //     ),
        //   ),
        // ],
      ),
      body: Container(decoration:BoxDecoration(gradient: AppColors.backgroundGradient),child: widgetList[widgetIndex],),
      bottomNavigationBar: CustomBottomNav(
          cIndex: _cIndex,
          tappingIndex: (index) {
            setState(() {
              widgetIndex = index;
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FAB(tappingIndex: (index) {
        setState(() {
          widgetIndex = index;
        });
      }),
      drawer: SideBar(),
    );
  }
}
