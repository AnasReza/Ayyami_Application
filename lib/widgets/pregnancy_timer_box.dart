import 'dart:async';
import 'dart:ui';

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
import 'app_text.dart';

class PregnancyTimerBox extends StatefulWidget {
  Function(bool mensis) mensis;

  PregnancyTimerBox({Key? key, required this.mensis}) : super(key: key);

  @override
  State<PregnancyTimerBox> createState() => _PregnancyTimerBoxState();
}

class _PregnancyTimerBoxState extends State<PregnancyTimerBox> with WidgetsBindingObserver {
  static late String uid;

  static late PregnancyProvider pray;
  static int secondsCount = 0;
  static int minutesCount = 0;
  static int hoursCount = 0;
  static int daysCount = 0;
  static int weeksCount = 0;
  static String mensesID = '';
  static final _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print('Timer Box is resumed');
        break;
      case AppLifecycleState.inactive:
        print('Timer Box is inactive');
        break;
      case AppLifecycleState.paused:
        print('Timer Box is paused');
        break;
      case AppLifecycleState.detached:
        print('Timer Box is detached');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PregnancyProvider>(builder: (conTimer, pro, build) {
      var userProvider = Provider.of<UserProvider>(context);
      uid = userProvider.getUid!;
      bool isTimerStart = pro.getTimerStart;

      pray = pro;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          /// Timer Container
          Container(
            width: 579.w,
            height: 205.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: AppColors.headingColor,
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
                        text: pro.weeks.toString(),
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
                        text: pro.days.toString(),
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
                        text: pro.hours.toString(),
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
                  showStartDialog();
                }else{
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

  void startService() async {
    print('service started');
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: onStart,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(autoStart: true, onForeground: onStart),
    );
    service.startService();
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) {
    DartPluginRegistrant.ensureInitialized();

    // if (pro.isTimerStart) {
    //   pro.stopTimer();
    // } else {
    //   pro.startTimer();
    // }
    startMensisTimer();

    // print('${stopwatch.elapsedMilliseconds}==millisecond');
    // Timer.periodic(Duration(seconds: 30), (timer) {
    //   print('Time is over');
    //
    //   print('${timer.tick}  ==sec');
    //   print('${stopwatch.elapsedMilliseconds}==millisecond');
    // });
  }

  static void startMensisTimer() {
    print('mensis timer started');

    Future<DocumentReference<Map<String, dynamic>>> menses = MensesRecord.uploadMensesStartTime(uid, Timestamp.now());
    menses.then((value) {
      // saveDocId(value.id);
      mensesID = value.id;
      print('${value.id} record doc id');
    });

    _stopWatch.secondTime.listen((event) {
      print('$secondsCount==sec    $minutesCount==minutes');
      secondsCount++;
      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
            if (daysCount > 30) {
              daysCount = 0;
            }
            pray.setDays(daysCount);
            hoursCount = 0;
          }
          pray.setHours(hoursCount);
          minutesCount = 0;
        } else if (minutesCount == 10) {
          _stopWatch.onStopTimer();
          _stopWatch.onResetTimer();
        }

        pray.setMin(minutesCount);
        secondsCount = 0;
      }

      pray.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
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
              var userProvider = Provider.of<UserProvider>(context, listen: false);
              var provider = Provider.of<PregnancyProvider>(context, listen: false);
              var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);

              PregnancyTracker().startPregnancyTimer(
                  userProvider, provider, userProvider.getUid!, tuhurProvider, Timestamp.fromDate(startDate));
              Navigator.pop(dialogContext);
            },
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
                  },);
                });
              }else{
                 var postNatalProvider = Provider.of<PostNatalProvider>(context, listen: false);
                 PregnancyTracker().stopPregnancyTimer(pregProvider, Timestamp.fromDate(endDate),'Given Birth');
                 PostNatalTracker().startPostNatalTimer(uid, postNatalProvider);
               }

              Navigator.pop(dialogContext);
            },
          );
        });
  }
}
