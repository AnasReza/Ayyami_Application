import 'package:adhan/adhan.dart';
import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/screens/prayer/prayer_timing.dart';
import 'package:ayyami/screens/profile/profile.dart';
import 'package:ayyami/screens/settings/settings.dart';
import 'package:ayyami/screens/supplications/supplications.dart';
import 'package:ayyami/utils/prayer_notification.dart';
import 'package:ayyami/widgets/side_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String fajr = '', sunrise = '', zuhar = '', asr = '', maghrib = '', isha = '';
  late DateTime fajrTime, sunriseTime, zuharTime, asrTime, maghribTime, ishaTime;

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

    PrayerNotification().notificationTime(fajrTime, sunriseTime, zuharTime, asrTime, maghribTime, ishaTime);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              _key.currentState!.openDrawer();
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTiming()));
            },
            child: SvgPicture.asset(
              AppImages.menuIcon,
              width: 44.w,
              height: 38.h,
            ),
          ),
        ),
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
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: widgetList[widgetIndex],
      ),
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
