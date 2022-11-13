import 'dart:async';

import 'package:ayyami/providers/prayer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import 'app_text.dart';

class TimerBox extends StatefulWidget {
  const TimerBox({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerBox> createState() => _TimerBoxState();
}

class _TimerBoxState extends State<TimerBox> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<PrayerProvider>(context);
    return Consumer<PrayerProvider>(
      builder: (context,child,build) {
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
                          text: pro.minutes.toString(),
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
                          text: pro.seconds.toString(),
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
                  if(pro.isTimerStart){
                    pro.stopTimer();
                  }else{
                    pro.startTimer();
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
                      text: pro.isTimerStart ? "STOP TIMER": "START TIMER",
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
      }
    );
  }
}
