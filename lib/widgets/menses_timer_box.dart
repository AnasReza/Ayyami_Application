import 'dart:async';
import 'dart:ui';

import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:workmanager/workmanager.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';
import '../constants/images.dart';
import '../dialog/timer_date_time.dart';
import '../providers/menses_provider.dart';
import '../providers/user_provider.dart';
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
  bool darkMode=false;

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
      bool isTimerStart = pro.getTimerStart;
      bool isTuhurStart = tuhurProvider.getTimerStart;
      darkMode=userProvider.getIsDarkMode;

      mensesProvider = pro;
      print('${pro.getDays.toString()} days from menses timer ');
      print('${pro.getHours.toString()} hours from menses timer ');
      return Stack(
        clipBehavior: Clip.none,
        children: [
          /// Timer Container
          Container(
            width: 579.w,
            height: 205.h,
            decoration: BoxDecoration(
              color: darkMode?AppDarkColors.white:AppColors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color:darkMode?AppDarkColors.headingColor:AppColors.headingColor,
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
                        text: pro.getDays.toString(),
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: 'Days',
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
                        text: pro.getHours.toString(),
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: 'Hours',
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
                        text: pro.getmin.toString(),
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: 'Min.',
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
                        text: pro.getSec.toString(),
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: 'Sec.',
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
                print('$start  start');
                int tuhurDays = tuhurProvider.getDays;
                int tuhurFrom=tuhurProvider.getFrom;
                if (!isTimerStart) {
                  if(isTuhurStart){
                    if(tuhurFrom==0){
                      if (tuhurDays >= tuhurMinimum) {
                        if (start) {
                          showStartDialog();
                        } else {
                          widget.mensis(true, '');
                          mensesProvider.setTimerStart(false);
                        }
                      } else {
                        var mensesID=Utils.getDocMensesID();
                        TuhurTracker().stopTimerWithDeletion(mensesID, "", mensesProvider, tuhurProvider, PostNatalProvider());
                        widget.mensis(true, '');
                        mensesProvider.setTimerStart(false);
                      }
                    }else{
                      toast_notification().toast_message('should_post-natal_again'.tr);
                    }

                  }else{
                    toast_notification().toast_message('should_tuhur_start'.tr);
                  }
                  
                } else {
                  showStopDialog();
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
                    text: isTimerStart ? "STOP TIMER" : "START TIMER",
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

  void showStartDialog() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return DialogDateTime(
            getDateTime: (date, time) {
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
              mensesTrack.startMensisTimer(mensesProvider, uid, tuhurProvider, Timestamp.fromDate(startDate));
              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
          );
        });
  }

  void showStopDialog() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return DialogDateTime(
            getDateTime: (date, time) {
              int year = date.year;
              int month = date.month;
              int day = date.day;
              int hour = time.hour;
              int minute = time.minute;
              String period = time.period.name;
              DateTime endDate = DateTime.utc(year, month, day, hour, minute);
              var dateString = DateFormat.yMEd().add_jms().format(endDate);
              print('$dateString  == dateString');

              var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
              UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

              String showRegulation = mensesTrack.stopMensesTimer(
                  mensesProvider, tuhurProvider, uid, userProvider, Timestamp.fromDate(endDate), widget.islamicMonth);

              widget.mensis(true, showRegulation);
              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
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
