import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';

class SideBarBottomView extends StatelessWidget {
  String text, image;
  bool darkMode;

  SideBarBottomView(this.text, this.image, this.darkMode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
          width: 1.w,
        ),
      ),
      child: Wrap(
        spacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          image.contains('.png')
              ? Image.asset(
                  image,
                  width: 50.w,
                  height: 50.h,
                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                )
              : SvgPicture.asset(
                  image,
                  width: 50.w,
                  height: 50.h,
                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                ),
          Text(
            text,
            style: TextStyle(
                color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                fontWeight: FontWeight.w400,
                fontSize: 30.sp),
          )
        ],
      ),
    );
  }
}
