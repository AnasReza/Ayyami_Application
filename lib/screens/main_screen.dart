import 'package:adhan/adhan.dart';
import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/screens/prayer/prayer_timing.dart';
import 'package:ayyami/screens/profile/profile.dart';
import 'package:ayyami/screens/settings/settings.dart';
import 'package:ayyami/screens/supplications/supplications.dart';

import 'package:ayyami/widgets/side_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/dark_mode_colors.dart';
import '../constants/images.dart';
import '../navigation/custom_bottom_nav.dart';
import '../navigation/custom_fab.dart';
import '../providers/namaz_provider.dart';
import '../providers/user_provider.dart';
import '../utils/prayer_notification.dart';
import 'home/home.dart';

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

  void getPrayerTiming(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var prayerProvider = Provider.of<NamazProvider>(context, listen: false);
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

    bool once = bool.hasEnvironment(getNamazStart().toString());
    print('$once boolean of namaz notification');
    if (!once) {
      saveNamazStart(true);
      PrayerNotification().notificationTime(fajrTime, sunriseTime, zuharTime, asrTime, maghribTime, ishaTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c,provider,child){
      getPrayerTiming(context);
      var darkMode=provider.getIsDarkMode;
      return Scaffold(
        key: _key,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:darkMode?AppDarkColors.white: Colors.white,
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
                color: darkMode?Colors.white:AppColors.grey,
              ),
            ),
          ),
          leadingWidth: 30,
          title: SvgPicture.asset(
            darkMode?AppImages.logo_white:AppImages.logo,
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
          decoration: BoxDecoration(gradient: darkMode?AppDarkColors.backgroundGradient:AppColors.backgroundGradient),
          child: widgetList[widgetIndex],
        ),
        bottomNavigationBar: CustomBottomNav(
          darkMode:darkMode,
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
    },);
  }

  void saveNamazStart(bool check) async {
    var box = await Hive.openBox('aayami');
    box.put('namaz_once', check).then((value) {
      print('data is saved');
    });
  }

  dynamic getNamazStart() async {
    var box = await Hive.openBox('aayami');
    return box.get('namaz_once', defaultValue: false);
  }
}
