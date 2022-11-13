import 'package:ayyami/constants/const.dart';
import 'package:ayyami/constants/routes.dart';
import 'package:ayyami/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../constants/images.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    Key? key,
    required int cIndex,
  })  : _cIndex = cIndex,
        super(key: key);

  final int _cIndex;

  @override
  Widget build(BuildContext context) {
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
          color: AppColors.headingColor,
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
        selectedItemColor: AppColors.headingColor,
        unselectedItemColor: AppColors.headingColor,
        items: [
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.profileBtn,
                    width: 42.w,
                    height: 34.h,
                    color: AppColors.headingColor,
                  ),
                  SizedBox(height: 9.h),
                ],
              ),
              label: 'Profile'),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.supplicationsBtn,
                    width: 42.w,
                    height: 34.h,
                    color: AppColors.headingColor,
                  ),
                  SizedBox(height: 9.h),
                ],
              ),
              label: 'Supplications'),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.prayerBtn,
                    width: 42.w,
                    height: 34.h,
                    color: AppColors.headingColor,
                  ),
                  SizedBox(height: 9.h),
                ],
              ),
              label: 'Prayer'),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.settingsBtn,
                    width: 42.w,
                    height: 34.h,
                    color: AppColors.headingColor,
                  ),
                  SizedBox(height: 9.h),
                ],
              ),
              label: 'Settings')
        ],
        onTap: (index) {
          print(index);

          if (index == 1) {
            Navigator.of(context).pushNamed(remindersRoute);
          }else if(index == 0){
            nextScreen(context, ProfilePage());
          }
        },
      ),
    );
  }
}
