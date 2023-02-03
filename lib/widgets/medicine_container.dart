import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/images.dart';

class MedicineContainer extends StatelessWidget {
  final String medicinetitle;
  final String medicineTime;
  bool darkMode;

  MedicineContainer({
    Key? key,
    required this.medicineTime,
    required this.medicinetitle,
    required this.darkMode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 180.w,
      height: 240.h,
      decoration: BoxDecoration(
        gradient: darkMode?AppDarkColors.backgroundGradient:AppColors.backgroundGradient,
        borderRadius: BorderRadius.circular(21.r),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    AppImages.edit_icon,
                    height: 32.h,
                    width: 32.w,
                    color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              medicineTime,
              style: TextStyle(
                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.261,
              ),
            ),
            Text(medicinetitle,
                style: TextStyle(
                  color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.261,
                ))
          ],
        ),
      ),
    );
  }
}
