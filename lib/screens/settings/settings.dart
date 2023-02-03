import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/const.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/settings/change_location.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/dark_mode_colors.dart';
import '../../dialog/rate_dialog.dart';
import '../../widgets/app_text.dart';
import '../../widgets/category_box with_switch.dart';
import '../../widgets/category_box.dart';

class SettingsApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      var darkMode = provider.getIsDarkMode;
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: "Settings",
                fontSize: 45.sp,
                fontWeight: FontWeight.w700,
                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
              ),
              SizedBox(
                height: 20,
              ),
              //CHANGE LOCATION
              GestureDetector(
                child: CategoryBox(
                  categoryName: 'change_location'.tr,
                  days: 21,
                  hours: 12,
                  checkbox: false,
                  isSelected: false,
                  comingSoon: false,
                  showDate: false,
                  darkMode:darkMode,
                ),
                onTap: () {
                  nextScreen(context, ChangeLocation());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              //CHANGE Language
              CategoryBox(
                categoryName: 'change_language'.tr,
                days: 21,
                hours: 12,
                checkbox: false,
                isSelected: false,
                comingSoon: false,
                showDate: false,
                darkMode:darkMode,
              ),
              const SizedBox(
                height: 20,
              ),
              //CGANGE THEME
              CategoryBox(
                categoryName: 'change_theme'.tr,
                days: 21,
                hours: 12,
                checkbox: false,
                comingSoon: true,
                isSelected: false,
                showDate: false,
                darkMode:darkMode,
              ),
              const SizedBox(
                height: 20,
              ),
              //TRACKER FACE
              CategoryBox(
                categoryName: 'change_tracker_face'.tr,
                days: 21,
                hours: 12,
                checkbox: false,
                isSelected: false,
                comingSoon: true,
                showDate: false,
                darkMode:darkMode,
              ),
              const SizedBox(
                height: 20,
              ),
              //DARK MODE
              CategoryBoxWithSwitch(
                categoryName: 'dark_mode'.tr,
                darkMode: darkMode,
                comingSoon: false,
                onchange: (onChangeValue) {
                  provider.setDarkMode(onChangeValue);
                  Utils.saveAppData(onChangeValue, 'dark_mode');
                },
              ),

              const SizedBox(
                height: 20,
              ),
              //BUY PREMIUM
              CategoryBox(
                categoryName: 'buy_premium'.tr,
                days: 21,
                hours: 12,
                checkbox: false,
                isSelected: false,
                comingSoon: false,
                showDate: false,
                darkMode:darkMode,
              ),
              const SizedBox(
                height: 20,
              ),
              //RATE APP
              GestureDetector(
                child: CategoryBox(
                  categoryName: 'rate_app'.tr,
                  days: 21,
                  hours: 12,
                  checkbox: false,
                  isSelected: false,
                  comingSoon: false,
                  showDate: false,
                  darkMode:darkMode,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return RateDialog(darkMode:darkMode);
                      },
                      useSafeArea: true);
                },
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
