import 'package:adhan/adhan.dart';
import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/firebase_calls/post-natal_record.dart';
import 'package:ayyami/firebase_calls/pregnancy_record.dart';
import 'package:ayyami/screens/prayer/prayer_timing.dart';
import 'package:ayyami/screens/profile/profile.dart';
import 'package:ayyami/screens/settings/settings.dart';
import 'package:ayyami/screens/supplications/supplications.dart';
import 'package:ayyami/widgets/side_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../constants/dark_mode_colors.dart';
import '../constants/images.dart';
import '../firebase_calls/menses_record.dart';
import '../firebase_calls/tuhur_record.dart';
import '../navigation/custom_bottom_nav.dart';
import '../providers/namaz_provider.dart';
import '../providers/user_provider.dart';
import '../translation/app_translation.dart';
import '../utils/notification.dart';
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
  List<Widget> widgetList = [
    const ProfilePage(),
    const Supplications(),
    const HomeScreen(),
    const PrayerTiming(),
    SettingsApp()
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String fajr = '', sunrise = '', zuhar = '', asr = '', maghrib = '', isha = '';
  late DateTime fajrTime,
      sunriseTime,
      zuharTime,
      asrTime,
      maghribTime,
      ishaTime;

  void getPrayerTiming(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var prayerProvider = Provider.of<NamazProvider>(context, listen: false);
    var currentPoints = userProvider.getCurrentPoint;
    final coordinates =
        Coordinates(currentPoints.latitude, currentPoints.longitude);
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

    prayerProvider.setFajarDateTime(fajrTime);
    prayerProvider.setSunriseDateTime(sunriseTime);
    prayerProvider.setDuhurDateTime(asrTime);
    prayerProvider.setAsrDateTime(fajrTime);
    prayerProvider.setMaghribDateTime(maghribTime);
    prayerProvider.setIshaDateTime(ishaTime);

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
      SendNotification().prayerNotificationTime(fajrTime, sunriseTime,
          zuharTime, asrTime, maghribTime, ishaTime, userProvider);
    }
  }

  @override
  void initState() {
    print("======MAIN SCREEN======\n");
    super.initState();
    var provider = context.read<UserProvider>();
    MensesRecord().getAllMensesRecord(provider.getUid).listen((event) {
      var docs = event.docs;
      provider.setAllMensesData(docs);
      List<PickerDateRange> dateRangeList = [];
      print('${docs.length}  user menses length');
      for (var doc in docs) {
        Timestamp? start =
            doc.data().containsKey('start_date') ? doc['start_date'] : null;
        Timestamp? end =
            doc.data().containsKey('end_time') ? doc['end_time'] : null;
        dateRangeList.add(PickerDateRange(
            start!.toDate(), end == null ? null : end.toDate()));
      }
      provider.setMensesDate(dateRangeList);
    });
    TuhurRecord().getAllTuhurRecord(provider.getUid).listen((event) {
      var docs = event.docs;
      provider.setAllTuhurData(docs);
    });
    PregnancyRecord().getAllPregnancyRecord(provider.getUid).listen((event) {
      var docs = event.docs;
      provider.setAllPregnancyData(docs);
    });
    PostNatalRecord().getAllPostNatalRecord(provider.getUid).listen((event) {
      var docs = event.docs;
      provider.setAllPostNatalData(docs);
    });

    getPrayerTiming(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (c, provider, child) {
        var darkMode = provider.getIsDarkMode;
        var lang = provider.getLanguage;
        var text = AppTranslate().textLanguage[lang];
        List<String> textList = [
          text!['add_members']!,
          text['calender']!,
          text['reminders']!,
          text['tracker']!,
          text['cycle_history']!,
          text['ask_mufti']!
        ];
        String invite = text['invite']!;
        String about = text['about_us_text']!;
        String logout = text['logout']!;
        String delete = text['delete_account']!;
        String delete_question = text['delete_account_question']!;
        String yes = text['yes']!;
        String no = text['no']!;
        String deleting = text['deleting']!;
        return Scaffold(
          key: _key,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: darkMode ? AppDarkColors.white : Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  _key.currentState!.openDrawer();
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTiming()));
                },
                child: SvgPicture.asset(
                  AppImages.menuIcon,
                  width: 44.w,
                  height: 38.h,
                  color: darkMode ? Colors.white : AppColors.grey,
                ),
              ),
            ),
            leadingWidth: 30,
            title: SvgPicture.asset(
              darkMode ? AppImages.logo_white : AppImages.logo,
              width: 249.6.w,
              height: 78.36.h,
            ),
            centerTitle: true,
          ),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: darkMode
                  ? AppDarkColors.backgroundGradient
                  : AppColors.backgroundGradient,
            ),
            child: widgetList[widgetIndex],
          ),
          bottomNavigationBar: CustomBottomNav(
              darkMode: darkMode,
              cIndex: _cIndex,
              tappingIndex: (index) {
                setState(() {
                  widgetIndex = index;
                });
              }),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: FAB(tappingIndex: (index) {
          //   setState(() {
          //     widgetIndex = index;
          //   });
          // }),
          drawer: SideBar(textList, invite, about, logout, delete,
              delete_question, yes, no, deleting),
        );
      },
    );
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
