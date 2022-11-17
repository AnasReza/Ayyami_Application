import 'dart:async';

import 'package:ayyami/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../providers/timer_provider.dart';
import '../providers/user_provider.dart';
import 'app_text.dart';

class TimerBox extends StatefulWidget {
  Function(bool mensis) mensis;

  TimerBox({Key? key, required this.mensis}) : super(key: key);

  @override
  State<TimerBox> createState() => _TimerBoxState();
}

class _TimerBoxState extends State<TimerBox> {
  final int tuhur = 15;
  final _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);
  late TimerProvider pray;
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(builder: (conTimer, pro, build) {
      var userProvider = Provider.of<UserProvider>(context);
      String uid = userProvider.getUid!;
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
                if (!isTimerStart) {
                  if (tuhur >= 15) {
                    //startService(pro);
                    showStartDialog();

                  } else {
                    widget.mensis(true);
                    pray.setTimerStart(false);
                  }
                } else {
                  if(minutesCount<=3){
                    toast_notification().toast_message('stop_mensus_timer_message'.tr);
                  }else{
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

  void startService() async {
    print('service started');
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        autoStart: true,
        onStart: onStart,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(autoStart: true, onForeground: onStart),
    );
    service.startService();
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) {
    // if (pro.isTimerStart) {
    //   pro.stopTimer();
    // } else {
    //   pro.startTimer();
    // }
    Timer.periodic(Duration(seconds: 30), (timer) {
      print('Time is over');
    });
  }

  void startMensisTimer() {
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
            pray.setDays(daysCount);
            hoursCount = 0;
          }
          pray.setHours(hoursCount);
          minutesCount = 0;
        }else if(minutesCount==10){
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
          return AlertDialog(
            title: Text(
              'start_timer'.tr,
            ),
            content: Text('start_menses'.tr),
            actions: [
              InkWell(
                child: Text(
                  'yes'.tr,
                ),
                onTap: () {

                  widget.mensis(false);
                  pray.setTimerStart(true);
                  startMensisTimer();
                  Navigator.pop(dialogContext);
                },
              ),

              InkWell(
                child: Text(
                  'no'.tr,
                ),
                onTap: () {
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          );
        });
  }

  void showStopDialog() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(
              'stop_timer'.tr,
            ),
            content: Text('stop_menses'.tr),
            actions: [
              InkWell(
                child: Text(
                  'yes'.tr,
                ),
                onTap: () {
                  _stopWatch.onStopTimer();
                  _stopWatch.onResetTimer();
                  pray.setTimerStart(false);
                  widget.mensis(true);
                  Navigator.pop(dialogContext);
                },
              ),

              InkWell(
                child: Text(
                  'no'.tr,
                ),
                onTap: () {
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          );
        });
  }
}
