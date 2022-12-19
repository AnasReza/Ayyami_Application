import 'dart:async';
import 'dart:ui';

import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
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
import '../providers/user_provider.dart';
import 'app_text.dart';

class TimerBox extends StatefulWidget {
  Function(bool mensis) mensis;

  TimerBox({Key? key, required this.mensis}) : super(key: key);

  @override
  State<TimerBox> createState() => _TimerBoxState();
}

class _TimerBoxState extends State<TimerBox> with WidgetsBindingObserver {
  static late String uid;
  static int tuhurMinimum = 15;
  static late MensesProvider mensesProvider;
  static int secondsCount = 0;
  static int minutesCount = 0;
  static int hoursCount = 0;
  static int daysCount = 0;
  static final _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);
  MensesTracker mensesTrack = MensesTracker();

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
    return Consumer<MensesProvider>(builder: (conTimer, pro, build) {
      var userProvider = Provider.of<UserProvider>(context);
      uid = userProvider.getUid!;
      bool isTimerStart = pro.getTimerStart;

      mensesProvider = pro;
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

                if (!isTimerStart) {
                  if (tuhurMinimum >= 15) {
                    if (start) {
                      showStartDialog();
                    } else {
                      widget.mensis(true);
                      mensesProvider.setTimerStart(false);
                    }
                  } else {
                    widget.mensis(true);
                    mensesProvider.setTimerStart(false);
                  }
                } else {
                  if (minutesCount >= 3) {
                    toast_notification().toast_message('stop_mensus_timer_message'.tr);
                  } else {
                    showStopDialog();
                  }
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
            mensesProvider.setDays(daysCount);
            hoursCount = 0;
          }
          mensesProvider.setHours(hoursCount);
          minutesCount = 0;
        } else if (minutesCount == 10) {
          _stopWatch.onStopTimer();
          _stopWatch.onResetTimer();
        }

        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }

      mensesProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void showStartDialog() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return DialogDateTime(
            getDateTime: (date, time) {
              int year=date.year;
              int month=date.month;
              int day=date.day;
              int hour=time.hour;
              int minute=time.minute;
              String period=time.period.name;
              DateTime startDate=DateTime.utc(year,month,day,hour,minute);
              var dateString=DateFormat.yMEd().add_jms().format(startDate);
              print('$dateString  == dateString');

              var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
              widget.mensis(false);
              mensesProvider.setTimerStart(true);
              // startService();
              mensesTrack.startMensisTimer(mensesProvider, uid, tuhurProvider,Timestamp.fromDate(startDate));
              Navigator.pop(dialogContext);
            },
          );
        });
    // showDialog(
    //     context: context,
    //     builder: (dialogContext) {
    //       return AlertDialog(
    //         title: Text(
    //           'start_timer'.tr,
    //         ),
    //         content: Text('start_menses'.tr),
    //         actions: [
    //           InkWell(
    //             child: Text(
    //               'yes'.tr,
    //             ),
    //             onTap: () {
    //               var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
    //               widget.mensis(false);
    //               mensesProvider.setTimerStart(true);
    //               // startService();
    //               mensesTrack.startMensisTimer(mensesProvider, uid, tuhurProvider);
    //               Navigator.pop(dialogContext);
    //             },
    //           ),
    //           InkWell(
    //             child: Text(
    //               'no'.tr,
    //             ),
    //             onTap: () {
    //               Navigator.pop(dialogContext);
    //             },
    //           ),
    //         ],
    //       );
    //     });
  }

  void showStopDialog() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return DialogDateTime(
            getDateTime: (date, time) {
              int year=date.year;
              int month=date.month;
              int day=date.day;
              int hour=time.hour;
              int minute=time.minute;
              String period=time.period.name;
              DateTime startDate=DateTime.utc(year,month,day,hour,minute);
              var dateString=DateFormat.yMEd().add_jms().format(startDate);
              print('$dateString  == dateString');

              var tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
              UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

              mensesTrack.stopMensesTimer(mensesProvider, tuhurProvider, uid, userProvider,Timestamp.fromDate(startDate));

              widget.mensis(true);
              Navigator.pop(dialogContext);
            },
          );
        });
    // showDialog(
    //     context: context,
    //     builder: (dialogContext) {
    //       return AlertDialog(
    //         title: Text(
    //           'stop_timer'.tr,
    //         ),
    //         content: Text('stop_menses'.tr),
    //         actions: [
    //           InkWell(
    //             child: Text(
    //               'yes'.tr,
    //             ),
    //             onTap: () {
    //               TuhurProvider tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
    //               UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    //
    //               mensesTrack.stopMensesTimer(mensesProvider, tuhurProvider, uid, userProvider);
    //
    //               widget.mensis(true);
    //               Navigator.pop(dialogContext);
    //             },
    //           ),
    //           InkWell(
    //             child: Text(
    //               'no'.tr,
    //             ),
    //             onTap: () {
    //               Navigator.pop(dialogContext);
    //             },
    //           ),
    //         ],
    //       );
    //     });
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
