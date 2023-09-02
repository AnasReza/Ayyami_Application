import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';
import '../constants/images.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    Key? key,
    required int cIndex,
    required this.tappingIndex,
    required this.darkMode,
  }) : super(key: key);

  final bool darkMode;
  final Function(int tappingIndex) tappingIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      var lang = provider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      return Container(
        width: double.infinity,
        height: 80,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: darkMode
              ? AppDarkColors.lightGreyBoxColor
              : AppColors.lightGreyBoxColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: darkMode ? Colors.white : AppColors.headingColor,
            width: 1,
            // strokeAlign: StrokeAlign.inside,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1e1f3d73),
              offset: Offset(0, -12),
              blurRadius: 40,
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width:2),
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppImages.profileBtn,
                      width: 42.w,
                      height: 34.h,
                      color: darkMode
                          ? AppDarkColors.headingColor
                          : AppColors.headingColor),
                  SizedBox(height: 9.h),
                  Text(
                    text!['profile']!,
                    style: TextStyle(
                        color: darkMode
                            ? AppDarkColors.headingColor
                            : AppColors.headingColor),
                  ),
                ],
              ),
              onTap: () {
                tappingIndex(0);
              },
            ),
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.supplicationsBtn,
                    width: 42.w,
                    height: 34.h,
                    color: darkMode
                        ? AppDarkColors.headingColor
                        : AppColors.headingColor,
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    text['supplications']!,
                    style: TextStyle(
                        color: darkMode
                            ? AppDarkColors.headingColor
                            : AppColors.headingColor),
                  )
                ],
              ),
              onTap: () {
                tappingIndex(1);
              },
            ),
            GestureDetector(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    gradient: AppColors.bgPinkishGradient,
                    shape: BoxShape.circle),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.homeBtn,
                      width: 42.w,
                      height: 34.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 9.h),
                    const Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              onTap: () {
                tappingIndex(2);
              },
            ),
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.prayerBtn,
                    width: 42.w,
                    height: 34.h,
                    color: darkMode
                        ? AppDarkColors.headingColor
                        : AppColors.headingColor,
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    text['prayer']!,
                    style: TextStyle(
                        color: darkMode
                            ? AppDarkColors.headingColor
                            : AppColors.headingColor),
                  )
                ],
              ),
              onTap: () {
                tappingIndex(3);
              },
            ),
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.settingsBtn,
                    width: 42.w,
                    height: 34.h,
                    color: darkMode
                        ? AppDarkColors.headingColor
                        : AppColors.headingColor,
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    text['settings']!,
                    style: TextStyle(
                        color: darkMode
                            ? AppDarkColors.headingColor
                            : AppColors.headingColor),
                  )
                ],
              ),
              onTap: () {
                tappingIndex(4);
              },
            ),
            const SizedBox(width: 2),
          ],
        ),
      );
    });
  }
}
