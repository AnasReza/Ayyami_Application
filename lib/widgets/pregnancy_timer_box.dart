import 'dart:async';
import 'dart:ui';

import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/dialog/misscrriage_dialog.dart';
import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/tracker/post-natal_tracker.dart';
import 'package:ayyami/tracker/pregnancy_tracker.dart';
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
import '../constants/images.dart';
import '../dialog/timer_date_time.dart';
import '../providers/menses_provider.dart';
import '../providers/pregnancy_timer_provider.dart';
import '../providers/user_provider.dart';
import '../translation/app_translation.dart';
import 'app_text.dart';

class PregnancyTimerBox extends StatefulWidget {


  PregnancyTimerBox({Key? key}) : super(key: key);

  @override
  State<PregnancyTimerBox> createState() => _PregnancyTimerBoxState();
}

class _PregnancyTimerBoxState extends State<PregnancyTimerBox> {
  static late String uid;
  bool darkMode=false;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PregnancyProvider>(builder: (conTimer, pro, build) {
      var userProvider = Provider.of<UserProvider>(context);
      uid = userProvider.getUid!;
      bool isTimerStart = pro.getTimerStart;
      darkMode=userProvider.getIsDarkMode;
      var lang=userProvider.getLanguage;
      var text=AppTranslate().textLanguage[lang];
      return Stack(
        clipBehavior: Clip.none,
        children: [
          /// Timer Container
          Container(
            width: 579.w,
            height: 205.h,
            decoration: BoxDecoration(
              color: darkMode?AppDarkColors.lightGreyBoxColor:AppColors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
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
                  /// Weeks
                  Column(
                    children: [
                      AppText(
                        text: isTimerStart?pro.weeks.toString():'0',
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: 'Weeks',
                        color: AppColors.pink,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  ),

                  /// Days
                  Column(
                    children: [
                      AppText(
                        text: isTimerStart?pro.days.toString():'0',
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
                        text: isTimerStart?pro.hours.toString():'0',
                        color: AppColors.pink,
                        fontSize: 56.722694396972656.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: 'Hours.',
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
                if (!isTimerStart) {
                  showStartDialog(text!);
                }else{
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


  void showStartDialog(Map<String,String> text) {
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
              var userProvider = Provider.of<UserProvider>(context, listen: false);
              var provider = Provider.of<PregnancyProvider>(context, listen: false);
              var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);

              PregnancyTracker().startPregnancyTimer(
                  userProvider, provider, userProvider.getUid!, tuhurProvider, Timestamp.fromDate(startDate));
              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
            text: text,
          );
        });
  }

  void showStopDialog(Map<String,String> text) {
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
              var pregProvider = Provider.of<PregnancyProvider>(context, listen: false);
              var mensesProvider = Provider.of<MensesProvider>(context, listen: false);
              var startTime=pregProvider.getStartTime;
              var diff=endDate.difference(startTime.toDate());
               if(diff.inDays<252){
                showDialog(context: context, builder: (subContext){
                  return MiscarraigeDialog(reason: (reasonValue){
                    MensesTracker().startMensisTimer(mensesProvider, uid, tuhurProvider, Timestamp.now());
                    PregnancyTracker().stopPregnancyTimer(pregProvider, Timestamp.fromDate(endDate),reasonValue);
                    Navigator.pop(subContext);
                  },darkMode:darkMode,text: text,);
                });
              }else{
                 var postNatalProvider = Provider.of<PostNatalProvider>(context, listen: false);
                 PregnancyTracker().stopPregnancyTimer(pregProvider, Timestamp.fromDate(endDate),'Given Birth');
                 PostNatalTracker().startPostNatalTimer(uid, postNatalProvider);
               }

              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
            text: text,
          );
        });
  }
}
