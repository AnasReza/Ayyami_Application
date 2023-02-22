import 'dart:async';
import 'dart:ui';

import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/firebase_calls/likoria_record.dart';
import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/providers/likoria_timer_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/translation/app_translation.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import '../providers/user_provider.dart';
import 'app_text.dart';

class LikoriaTimerBox extends StatefulWidget {

  Function(bool dialog) showDialog;

  LikoriaTimerBox({Key? key, required this.showDialog}) : super(key: key);

  @override
  State<LikoriaTimerBox> createState() => _LikoriaTimerBoxState();
}

class _LikoriaTimerBoxState extends State<LikoriaTimerBox>  {
  static late String uid;
  bool darkMode=false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LikoriaTimerProvider>(builder: (conTimer, pro, child) {
      var userProvider = Provider.of<UserProvider>(context);
      var tuhurProvider = Provider.of<TuhurProvider>(context,listen: false);
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
                child: Column(
                  children: [
                    GestureDetector(child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                      decoration: BoxDecoration(color: AppColors.yellow, borderRadius: BorderRadius.circular(15)),
                      child: const Text(
                        'Change Color',
                        style: TextStyle(color: AppColors.headingColor, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),onTap: (){
                      widget.showDialog(true);
                    },),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Days
                        Column(
                          children: [
                            AppText(
                              text:isTimerStart?pro.days.toString():'0',
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
                              text: isTimerStart?pro.getmin.toString():'0',
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
                              text: isTimerStart?pro.getSec.toString():'0',
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
                  ],
                )),
          ),

          /// Timer Container Button
          Positioned(
            // left: 204.w,
            right: 140.w,
            top: 234.h,
            child: InkWell(
              onTap: () {
                if(pro.isSelected){
                  if (!isTimerStart) {
                    if(tuhurProvider.isTimerStart){
                      showStartDialog(text!);
                    }
                  } else {
                    showStopDialog(text!);
                  }
                }else{
                  toast_notification().toast_message(text!['likoria_color_selected']!);
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

  void showStartDialog(Map<String, String> text) {
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
              var provider= Provider.of<LikoriaTimerProvider>(context,listen: false);

              var colorSelected=provider.selectedColor;

              LikoriaRecord().uploadLikoriaStartTime(uid, Timestamp.fromDate(startDate),colorSelected.value);
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
              int year = date.year;
              int month = date.month;
              int day = date.day;
              int hour = time.hour;
              int minute = time.minute;
              String period = time.period.name;
              DateTime startDate = DateTime.utc(year, month, day, hour, minute);
              var dateString = DateFormat.yMEd().add_jms().format(startDate);
              print('$dateString  == dateString');
              var provider= Provider.of<LikoriaTimerProvider>(context,listen: false);

              var colorSelected=provider.selectedColor;

              LikoriaRecord().uploadLikoriaStartTime(uid, Timestamp.fromDate(startDate),colorSelected.value);
              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
            text: text,
          );
        });
  }

}
