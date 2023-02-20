import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/side_bar_bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/dark_mode_colors.dart';
import '../../constants/images.dart';
import '../../translation/app_translation.dart';

class AboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutUsState();
  }
}

class AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      var darkMode = provider.getIsDarkMode;
      var lang = provider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: darkMode ? AppDarkColors.white : AppColors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: SvgPicture.asset(
            darkMode ? AppImages.logo_white : AppImages.logo,
            width: 249.6.w,
            height: 78.4.h,
            // color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration:
              BoxDecoration(gradient: darkMode! ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient),
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset(
                        AppImages.backIcon,
                        width: 49.w,
                        height: 34.h,
                        color: darkMode! ? AppDarkColors.headingColor : AppColors.headingColor,
                      ),
                    ),
                    SizedBox(width: 110.w),
                    Text(
                      'About Us',
                      style: TextStyle(
                        color: darkMode! ? AppDarkColors.headingColor : AppColors.headingColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  text!['about_us']!,
                  style: TextStyle(
                      color: darkMode! ? AppDarkColors.headingColor : AppColors.headingColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text!['verified_by']!,
                      style: TextStyle(
                          color: darkMode! ? AppDarkColors.headingColor : AppColors.headingColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Image.asset(
                      AppImages.deobandIcon,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SideBarBottomView('suggest_update'.tr, AppImages.suggestIcon, darkMode)
              ],
            ),
          ),
        ),
      ));
    });
  }
}
