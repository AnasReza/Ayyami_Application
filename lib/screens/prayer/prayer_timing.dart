import 'dart:async';

import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/providers/namaz_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/prayer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../translation/app_translation.dart';
import '../../widgets/app_text.dart';

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
  final List<DateTime> _events = [];
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
      hijriDateFormated = _hijriDateToday.toFormat('dd MMMM yyyy');
      gorgeonTodayDateFormated = _todayDateFormated.format(_gorgeonDateToday);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NamazProvider>(builder: (consumerContext, provider, child) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var darkMode = userProvider.getIsDarkMode;
      var lang = userProvider.getLanguage;
      var text = AppTranslate().textLanguage[lang];

      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient),
        padding: EdgeInsets.only(left: 70.w, right: 70.w, top: 80.h, bottom: 30),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                SizedBox(height: 70.6.h),
                AppText(
                  text: text!['prayer_times']!,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w700,
                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppText(
                  textAlign: TextAlign.center,
                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
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
                  id: 0,
                  show: userProvider.getShowFajar,
                ),
                SizedBox(
                  height: 50.h,
                ),
                PrayerWidget(
                  name: text['sunrise']!,
                  time: provider.getSunriseTime,
                  darkMode: darkMode,
                  id: 1,
                  show: userProvider.getShowSunrise,
                ),
                SizedBox(
                  height: 50.h,
                ),
                PrayerWidget(
                  name: text['duhur']!,
                  time: provider.getDuhurTime,
                  darkMode: darkMode,
                  id: 2,
                  show: userProvider.getShowDuhur,
                ),
                SizedBox(
                  height: 50.h,
                ),
                PrayerWidget(
                  name: text['asar']!,
                  time: provider.getAsrTime,
                  darkMode: darkMode,
                  id: 3,
                  show: userProvider.getShowAsr,
                ),
                SizedBox(
                  height: 50.h,
                ),
                PrayerWidget(
                  name: text['maghrib']!,
                  time: provider.getMaghribTime,
                  darkMode: darkMode,
                  id: 4,
                  show: userProvider.getShowMaghrib,
                ),
                SizedBox(
                  height: 50.h,
                ),
                PrayerWidget(
                  name: text['isha']!,
                  time: provider.getIshaTime,
                  darkMode: darkMode,
                  id: 5,
                  show: userProvider.getShowIsha,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
