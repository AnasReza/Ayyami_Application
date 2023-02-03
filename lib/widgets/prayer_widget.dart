import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class PrayerWidget extends StatefulWidget {
  PrayerWidget({
    Key? key,
    required this.name,
    required this.time,
    required this.darkMode
  }) : super(key: key);

  final String name;
  final String time;
  bool darkMode;


  @override
  State<PrayerWidget> createState() => _PrayerWidgetState();
}

class _PrayerWidgetState extends State<PrayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 558.w,
      height: 104.h,
      decoration: BoxDecoration(
        color: widget.darkMode?AppDarkColors.lightGreyBoxColor:AppColors.lightGreyBoxColor,
        border: Border.all(
          color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1e1f3d73),
              offset: Offset(0, 12),
              blurRadius: 40,
              spreadRadius: 0)
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          36.w,
          19.h,
          54.w,
          21.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppText(
                text: widget.name,
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            AppText(
                text: widget.time,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700),
            SizedBox(width: 30.w),
            Image.asset(AppImages.bellIcon,height: 20,color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,)
          ],
        ),
      ),
    );
  }
}
