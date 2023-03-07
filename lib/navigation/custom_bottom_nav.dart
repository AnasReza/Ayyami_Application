import 'package:ayyami/constants/const.dart';
import 'package:ayyami/constants/routes.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/profile/profile.dart';
import 'package:ayyami/screens/settings/settings.dart';
import 'package:ayyami/screens/supplications/supplications.dart';
import 'package:ayyami/translation/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';
import '../constants/images.dart';
import '../screens/prayer/prayer_timing.dart';

class CustomBottomNav extends StatelessWidget {
  CustomBottomNav({
    Key? key,
    required int cIndex,
    required this.tappingIndex,
    required this.darkMode,
  })  : _cIndex = cIndex,
        super(key: key);

  final int _cIndex;
  bool darkMode;
  final Function(int tappingIndex) tappingIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c,provider,child){
      var lang=provider.getLanguage;
      var text=AppTranslate().textLanguage[lang];
      return Container(
        width: 720.w,
        height: 126.757.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.r),
            topRight: Radius.circular(35.r),
          ),
          border: Border.all(
            color: darkMode ? Colors.white : AppColors.headingColor,
            width: 1.w,
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
        child: BottomNavigationBar(
          currentIndex: _cIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
          unselectedItemColor: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
          backgroundColor: darkMode?AppDarkColors.darkNav:Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.profileBtn,
                    width: 42.w,
                    height: 34.h,
                    color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                  ),
                  SizedBox(height: 9.h),
                ],
              ),
              label: text!['profile'],
            ),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SvgPicture.asset(
                      AppImages.supplicationsBtn,
                      width: 42.w,
                      height: 34.h,
                      color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                    ),
                    SizedBox(height: 9.h),
                  ],
                ),
                label: text['supplications']),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SvgPicture.asset(
                      AppImages.prayerBtn,
                      width: 42.w,
                      height: 34.h,
                      color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                    ),
                    SizedBox(height: 9.h),
                  ],
                ),
                label: text['prayer']),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SvgPicture.asset(
                      AppImages.settingsBtn,
                      width: 42.w,
                      height: 34.h,
                      color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                    ),
                    SizedBox(height: 9.h),
                  ],
                ),
                label: text['settings'])
          ],
          onTap: (index) {
            print(index);

            if (index == 0) {
              tappingIndex(index);
              // nextScreen(context, ProfilePage());
            } else if (index == 1) {
              tappingIndex(index);
              // Navigator.of(context).pushNamed(remindersRoute);
              // nextScreen(context, Supplications());
            } else if (index == 2) {
              tappingIndex(index + 1);
              // nextScreen(context, PrayerTiming());
            } else if (index == 3) {
              tappingIndex(index + 1);
              // nextScreen(context, Settings());
            }
          },
        ),
      );
    });

  }
}
