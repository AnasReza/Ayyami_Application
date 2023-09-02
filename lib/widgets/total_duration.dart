import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class TotalDuration extends StatelessWidget {
  final Map<String, String> text;
  final String lang, days, hours, minutes;

  const TotalDuration(
      {required this.text,
      required this.lang,
      required this.days,
      required this.hours,
      required this.minutes,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: AppColors.totalColor, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              text!['total_duration']!,
              textDirection: lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
              style:
                  TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.w700, fontFamily: 'DMSans'),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    days,
                    style: TextStyle(
                        color: AppDarkColors.headingColor,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DMSans'),
                  ),
                  Text(
                    text['days']!,
                    style: TextStyle(
                        color: AppDarkColors.headingColor,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSans'),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    hours,
                    style: TextStyle(
                        color: AppDarkColors.headingColor,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DMSans'),
                  ),
                  Text(
                    text['hours']!,
                    style: TextStyle(
                        color: AppDarkColors.headingColor,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSans'),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    minutes,
                    style: TextStyle(
                        color: AppDarkColors.headingColor,
                        fontSize:35.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DMSans'),
                  ),
                  Text(
                    text['minutes']!,
                    style: TextStyle(
                        color: AppDarkColors.headingColor,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSans'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
