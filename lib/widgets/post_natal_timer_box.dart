import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/providers/habit_provider.dart';
import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/pregnancy_timer_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/post-natal_tracker.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../dialog/timer_date_time.dart';
import '../providers/post-natal_timer_provider.dart';
import '../providers/user_provider.dart';
import '../translation/app_translation.dart';
import 'app_text.dart';

class PostNatalTimerBox extends StatefulWidget {
  const PostNatalTimerBox({
    Key? key,
  }) : super(key: key);

  @override
  State<PostNatalTimerBox> createState() => _PostNatalTimerBoxState();
}

class _PostNatalTimerBoxState extends State<PostNatalTimerBox> {
  static late String uid;
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostNatalProvider>(builder: (conTimer, pro, build) {
      var userProvider = Provider.of<UserProvider>(context);
      var pregProvider = Provider.of<PregnancyProvider>(context);
      uid = userProvider.getUid!;
      bool isTimerStart = pro.getTimerStart;
      bool pregStart = pregProvider.getTimerStart;
      darkMode = userProvider.getIsDarkMode;
      var lang = userProvider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      return Stack(
        clipBehavior: Clip.none,
        children: [
          /// Timer Container
          Container(
            decoration: BoxDecoration(
              color:
                  darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: darkMode
                    ? AppDarkColors.headingColor
                    : AppColors.headingColor,
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
                        text: isTimerStart ? pro.days.toString() : '0',
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
                        text: isTimerStart ? pro.hours.toString() : '0',
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
                        text: isTimerStart ? pro.getmin.toString() : '0',
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
                        text: isTimerStart ? pro.getSec.toString() : '0',
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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print("clicked");
                if (!isTimerStart) {
                  // if (!pregStart) {
                  //   toast_notification().toast_message('post_natal_message'.tr);
                  // } else {
                  //   toast_notification()
                  //       .toast_message('post_natal_automatically'.tr);
                  // }
                  showStartDialog(text);
                } else {
                  showStopDialog(text);
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
                    text: isTimerStart
                        ? text['stop_timer']!
                        : text['start_timer']!,
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
    var mensesProvider = Provider.of<MensesProvider>(context, listen: false);
    var pregProvider = Provider.of<PregnancyProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
    var habitProvider = Provider.of<HabitProvider>(context, listen: false);
    var postNatalProvider =
        Provider.of<PostNatalProvider>(context, listen: false);
    String postNatalDataId = userProvider.allPostNatalData.last.id;
    Map<String, dynamic> postNatalData =
        userProvider.allPostNatalData.last.data();
    bool isPregStart = pregProvider.isTimerStart;
    if (isPregStart) {
      var lang = userProvider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      toast_notification().toast_message(text!['post_natal_automatically']!);
    } else if (postNatalData['days'] >= 40) {
      toast_notification().toast_message(
          '40 days are already completed you must start menses timer now');
    }
    //show the dilaog if pregnancy isnt started yet and total postnatal days have space
    else {
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
                DateTime startDate = DateTime(year, month, day, hour, minute);
                print("else");

                // if(last postnatal days were less than max=40 add the remaining days to it):
                Timestamp lastPostNatalEndTime = postNatalData['end_time'];
                Timestamp currentPostNatalStartTime =
                    Timestamp.fromDate(startDate);
                int maxPostNatalDays = 40, validTuhurDays = 15;
                int diffbetweenPostNatals = currentPostNatalStartTime
                    .toDate()
                    .difference(lastPostNatalEndTime.toDate())
                    .inDays;
                // if diff bw FIRST two post natals is < 15 then it is postnatal else menses
                if (diffbetweenPostNatals < validTuhurDays) {
                  //if last postnatal days are less than 40
                  if (postNatalData['days'] < maxPostNatalDays) {
                    //if days have space to complete 40, start timer else max days exceed
                    // e.g 10L + 14T < 40>, have space of 5 days
                    if (postNatalData['days'] + diffbetweenPostNatals < 40) {
                      //continue last postNatal Timer
                      //delete current ongoing tuhur
                      TuhurTracker().stopTimerWithDeletion(
                          '',
                          postNatalDataId,
                          mensesProvider,
                          tuhurProvider,
                          userProvider,
                          postNatalProvider);
                      //habit will be updated at stop postNatal timer
                    } //if the days already 40 or more e.g 30L+14T
                    else {
                      //post Natal cant be started as it cant exceed 40 days. update the first 40 days were postnatal and rest istahada
                      toast_notification().toast_message(
                          '40 days are already completed you must start menses timer now');

                      //update last postNatal endtime to start+40 days
                      //update habit to 40 days
                      //continue last tuhur start from 40th day to no end
                      if (!postNatalProvider.getTimerStart) {
                        print("stopping postnatal timer ");
                        PostNatalTracker().stopPostNatalTimer(
                            userProvider,
                            postNatalData['start_date']
                                .toDate()
                                .add(const Duration(days: 40)),
                            postNatalProvider,
                            habitProvider,
                            tuhurProvider);
                      } else {
                        print("postnatal timer already stopped.");
                      }
                    }
                  } //else 40 days are already completed you must start menses timer now
                  else {
                    //show toast
                    toast_notification().toast_message(
                        '40 days are already completed you must start menses timer now');
                  }
                } // diff bw two post natals is > 15 hence its menses
                else {
                  toast_notification().toast_message(
                      'there was a valid 15 day gap, you must start menses timer now');
                }

                // var postNatalProvider =
                //     Provider.of<PostNatalProvider>(context, listen: false);
                // var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
                // var tuhurFrom = tuhurProvider.getFrom;
                // if (tuhurFrom == 1) {
                //   var postNatalID = postNatalProvider.getpostNatalID;
                //   TuhurRecord.deleteTuhurID('', postNatalID, tuhurProvider,
                //       MensesProvider(), postNatalProvider);
                // } else {
                //   toast_notification().toast_message('should_menses_again'.tr);
                // }
                //not letting user turn on postnatal at random  occasions
                // toast_notification().toast_message('should_postnatal_start'.tr);
                Navigator.pop(dialogContext);
              },
              darkMode: darkMode,
              text: text,
            );
          });
    }
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
              DateTime endDate = DateTime(year, month, day, hour, minute);
              var dateString = DateFormat.yMEd().add_jms().format(endDate);
              print('$dateString  == dateString');
              var userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              var tuhurProvider =
                  Provider.of<TuhurProvider>(context, listen: false);
              var postNatalProvider =
                  Provider.of<PostNatalProvider>(context, listen: false);
              var habitProvider =
                  Provider.of<HabitProvider>(context, listen: false);

              PostNatalTracker().stopPostNatalTimer(
                  userProvider,
                  Timestamp.fromDate(endDate),
                  postNatalProvider,
                  habitProvider,
                  tuhurProvider);

              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
            text: text,
          );
        });
  }
}
