import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/const.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/settings/change_location.dart';
import 'package:ayyami/translation/app_translation.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/dark_mode_colors.dart';
import '../../dialog/rate_dialog.dart';
import '../../firebase_calls/user_record.dart';
import '../../widgets/app_text.dart';
import '../../widgets/category_box with_switch.dart';
import '../../widgets/category_box.dart';
import 'choose_language.dart';

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
      var lang = provider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: text!['settings']!,
                fontSize: 45.sp,
                fontWeight: FontWeight.w700,
                color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
              ),
              SizedBox(
                height: 20,
              ),
              //CHANGE LOCATION
              Directionality(textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr, child: GestureDetector(
                child: CategoryBox(
                  categoryName: text!['change_location']!,
                  days: 21,
                  hours: 12,
                  checkbox: false,
                  isSelected: false,
                  comingSoon: false,
                  showDate: false,
                  darkMode: darkMode,
                  text: text,
                  textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr,
                ),
                onTap: () {
                  nextScreen(context, ChangeLocation());
                },
              ),),

              const SizedBox(
                height: 20,
              ),
              //CHANGE Language
              Directionality(textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr, child: GestureDetector(
                child: CategoryBox(
                  categoryName: text!['change_language']!,
                  days: 21,
                  hours: 12,
                  checkbox: false,
                  isSelected: false,
                  comingSoon: false,
                  showDate: false,
                  darkMode: darkMode,
                  text: text,
                  textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr,
                ),
                onTap: () {
                  nextScreen(context, ChooseLanguage());
                },
              ),),


              const SizedBox(
                height: 20,
              ),
              //CGANGE THEME
              Directionality(textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr, child: CategoryBox(
                categoryName: text!['change_theme']!,
                days: 21,
                hours: 12,
                checkbox: false,
                comingSoon: true,
                isSelected: false,
                showDate: false,
                darkMode: darkMode,
                text: text,
                textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr,
              ),),

              const SizedBox(
                height: 20,
              ),
              //TRACKER FACE
              Directionality(textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr, child: CategoryBox(
              categoryName: text!['change_tracker_face']!,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              comingSoon: true,
              showDate: false,
              text: text,
              darkMode: darkMode,
                textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr,
              ),),

              const SizedBox(
                height: 20,
              ),
              //DARK MODE
              Directionality(textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr, child: CategoryBoxWithSwitch(
                categoryName: text!['dark_mode']!,
                darkMode: darkMode,
                comingSoon: false,
                onchange: (onChangeValue) {

                  provider.setDarkMode(onChangeValue);
                  Utils.saveAppData(onChangeValue, 'dark_mode');
                  UsersRecord().updateDarkMode(provider.getUid!, onChangeValue);
                },
              ),),


              const SizedBox(
                height: 20,
              ),
              //BUY PREMIUM
              Directionality(textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr, child: CategoryBox(
                categoryName: text!['buy_premium']!,
                days: 21,
                hours: 12,
                checkbox: false,
                isSelected: false,
                comingSoon: false,
                showDate: false,
                darkMode: darkMode,
                text: text,
                textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr,
              ),),

              const SizedBox(
                height: 20,
              ),
              //RATE APP
              Directionality(textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr, child: GestureDetector(
                child: CategoryBox(
                  categoryName: text!['rate_app']!,
                  days: 21,
                  hours: 12,
                  checkbox: false,
                  isSelected: false,
                  comingSoon: true,
                  showDate: false,
                  darkMode: darkMode,
                  text: text,
                  textDirection: lang=='ur'?TextDirection.rtl:TextDirection.ltr,
                ),
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (dialogContext) {
                  //       return RateDialog(darkMode:darkMode);
                  //     },
                  //     useSafeArea: true);
                },
              ),),


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
