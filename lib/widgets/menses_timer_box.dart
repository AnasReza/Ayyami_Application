import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';
import '../constants/images.dart';
import '../dialog/timer_date_time.dart';
import '../providers/menses_provider.dart';
import '../providers/user_provider.dart';
import '../translation/app_translation.dart';
import 'app_text.dart';

class TimerBox extends StatefulWidget {
  Function(bool mensis, String regulationMessage) mensis;
  String islamicMonth;

  TimerBox({Key? key, required this.mensis, required this.islamicMonth}) : super(key: key);

  @override
  State<TimerBox> createState() => _TimerBoxState();
}

class _TimerBoxState extends State<TimerBox> {
  static late String uid;
  static int tuhurMinimum = 15;
  static late MensesProvider mensesProvider;
  static int secondsCount = 0;
  static int minutesCount = 0;
  static int hoursCount = 0;
  static int daysCount = 0;
  MensesTracker mensesTrack = MensesTracker();
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MensesProvider>(builder: (conTimer, pro, build) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
      uid = userProvider.getUid!;
      bool isMensesStart = pro.getTimerStart;
      bool isTuhurStart = tuhurProvider.getTimerStart;
      darkMode = userProvider.getIsDarkMode;
      var lang = userProvider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      mensesProvider = pro;
      print('${isTuhurStart} is tuhur start');

      return Stack(
        clipBehavior: Clip.none,
        children: [
          /// Timer Container
          Container(
            height: 210.h,
            decoration: BoxDecoration(
              color: darkMode ? AppDarkColors.white : AppColors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                width: 5.w,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x339567fb),
                  offset: Offset(0, 25),
                  blurRadius: 37.5,
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                59.w,
                25.h,
                66.3.w,
                50.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Days
                  Column(
                    children: [
                      AppText(
                        text: isMensesStart ? pro.getDays.toString() : '0',
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: text!['days']!,
                        color: AppColors.pink,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),

                  /// Hours
                  Column(
                    children: [
                      AppText(
                        text: isMensesStart ? pro.getHours.toString() : '0',
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: text['hours']!,
                        color: AppColors.pink,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),

                  /// Minutes
                  Column(
                    children: [
                      AppText(
                        text: isMensesStart ? pro.getmin.toString() : '0',
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: text['minutes']!,
                        color: AppColors.pink,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),

                  /// Seconds
                  Column(
                    children: [
                      AppText(
                        text: isMensesStart ? pro.getSec.toString() : '0',
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: text['seconds']!,
                        color: AppColors.pink,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// Timer Container Button
          Positioned(
            // left: 204.w,
            right: 140.w,
            top: 174.h,
            child: InkWell(
              onTap: () {
                bool start = calculateLastMenses();
                print('$start  start, $isTuhurStart  tuhurstart}');
                int tuhurDays = tuhurProvider.getDays;
                int tuhurFrom = tuhurProvider.getFrom;
                if (!isMensesStart) {
                  if (isTuhurStart) {
                    if (tuhurFrom == 0) {
                      showStartDialog(text!);
                      // if (tuhurDays >= tuhurMinimum) {
                      //   if (start) {
                      //
                      //   } else {
                      //     widget.mensis(true, '');
                      //     mensesProvider.setTimerStart(false);
                      //   }
                      // } else {
                      //   var mensesID = Utils.getDocMensesID();
                      //   MensesTracker().stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
                      //   widget.mensis(true, '');
                      //   mensesProvider.setTimerStart(false);
                      // }
                    } else {
                      toast_notification().toast_message(text['should_post-natal_again']!);
                    }
                  } else {
                    toast_notification().toast_message(text['should_tuhur_start']!);
                  }
                } else {
                  showStopDialog(text!);
                }
              },
              child: Container(
                width: 307.w,
                height: 62.573.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(56.5.r),
                  // gradient: AppColors.bgPinkishGradient,
                  image: const DecorationImage(
                    image: AssetImage(AppImages.rectBtnGradientColor),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: AppText(
                    text: isMensesStart ? text['stop_timer']! : text['start_timer']!,
                    color: AppColors.white,
                    fontSize: 26.36170196533203.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  bool calculateLastMenses() {
    try {
      var provider = Provider.of<UserProvider>(context, listen: false);
      var menseslast = provider.getLastMenses;
      var mensesEnd = provider.getLastMensesEnd;
      var tuhurLast = provider.getLastTuhur;
      DateTime now = DateTime.now();
      var menseslastdate = menseslast.toDate();
      var tuhurlastdate = tuhurLast.toDate();

      var mensesTimeMap = provider.getLastMensesTime;
      var tuhurTimeMap = provider.getLastTuhurTime;
      Duration tuhurDuration = Duration(
          days: tuhurTimeMap!['day']!,
          hours: tuhurTimeMap!['hours']!,
          minutes: tuhurTimeMap!['minutes']!,
          seconds: tuhurTimeMap!['second']!);
      var menses_should_start = menseslastdate.add(tuhurDuration);

      Duration diff = menses_should_start.difference(now);
      var mensesDiff = now.difference(mensesEnd.toDate());
      tuhurMinimum = mensesDiff.inDays;
      if (diff.inSeconds < 0) {
        return true;
      } else {
        int diffINT = diff.inSeconds;
        var diffDuration = timeLeft(diffINT);
        int secs = diffDuration.inSeconds;
        int totalSeconds = secs + diffINT;
        var duration = timeLeft(totalSeconds);
        if (duration.inDays > 10) {
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      return true;
    }
  }

  Duration timeLeft(int seconds) {
    int diff = seconds;

    int days = diff ~/ (24 * 60 * 60);
    diff -= days * (24 * 60 * 60);
    int hours = diff ~/ (60 * 60);
    diff -= hours * (60 * 60);
    int minutes = diff ~/ (60);
    diff -= minutes * (60);

    return Duration(days: days, hours: hours, minutes: minutes);
  }

  void showStartDialog(Map<String, String> text) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return DialogDateTime(
            getDateTime: (date, time) {
              print('from start dialog');
              int year = date.year;
              int month = date.month;
              int day = date.day;
              int hour = time.hour;
              int minute = time.minute;
              String period = time.period.name;
              DateTime startDate = DateTime.utc(year, month, day, hour, minute);
              var dateString = DateFormat.yMEd().add_jms().format(startDate);
              print('$dateString  == dateString');

              var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
              widget.mensis(false, '');
              mensesProvider.setTimerStart(true);
              // startService();
              mensesTrack.startMensisTimer(
                  mensesProvider, uid, tuhurProvider, Timestamp.fromDate(startDate));
              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
            text: text,
          );
        });
  }

  void showStopDialog(Map<String, String> text) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return DialogDateTime(
            getDateTime: (date, time) {
              print('from stop dialog');
              int year = date.year;
              int month = date.month;
              int day = date.day;
              int hour = time.hour;
              int minute = time.minute;
              String period = time.period.name;
              DateTime endDate = DateTime.utc(year, month, day, hour, minute);
              var dateString = DateFormat.yMEd().add_jms().format(endDate);
              print('$dateString  == dateString');
              var mensesProvider = Provider.of<MensesProvider>(context, listen: false);
              var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
              var userProvider = Provider.of<UserProvider>(context, listen: false);
              String message = MensesTracker().stopMensesTimer(mensesProvider, tuhurProvider, uid,
                  userProvider, Timestamp.fromDate(endDate), widget.islamicMonth, text);
              widget.mensis(true, message);
              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
            text: text,
          );
        });
  }

  static void saveDocId(String id) async {
    var box = await Hive.openBox('aayami_menses');
    box.put('menses_timer_doc_id', id);
  }

  dynamic getDocID() async {
    var box = await Hive.openBox('aayami_menses');
    return box.get('menses_timer_doc_id');
  }
}
