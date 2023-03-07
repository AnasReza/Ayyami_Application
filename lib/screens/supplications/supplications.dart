import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/const.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/supplications/supplications_details.dart';
import 'package:ayyami/screens/supplications/surah_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../translation/app_translation.dart';
import '../../widgets/app_text.dart';

class Supplications extends StatefulWidget {
  const Supplications({super.key});

  @override
  State<StatefulWidget> createState() {
    return SupplicationsState();
  }
}

class SupplicationsState extends State<Supplications> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      var darkMode = provider.getIsDarkMode;
      var lang=provider.getLanguage;
      var text=AppTranslate().textLanguage[lang];

      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: text!['supplications']!,
                fontSize: 45.sp,
                fontWeight: FontWeight.w700,
                color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
              ),
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor, width: 1)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ExpansionTile(
                        collapsedIconColor: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                        title: Text(
                          text['after_fajar']!,
                          style: TextStyle(
                              color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        backgroundColor: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        collapsedBackgroundColor:
                            darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        iconColor: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.supplicationsBtn,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['supplications']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SupplicationsDetails('fajar'));
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.bookIcon,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['surah']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SurahDetails('fajar', [text['surah_yaseen']!]));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor, width: 1)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ExpansionTile(
                        title: Text(
                          text['after_duhur']!,
                          style: TextStyle(
                              color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        backgroundColor: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        collapsedIconColor: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                        collapsedBackgroundColor:
                            darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        iconColor: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.supplicationsBtn,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['supplications']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SupplicationsDetails('zuhur'));
                                },
                              ),
const SizedBox(width: 20,),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.bookIcon,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['surah']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SurahDetails('zuhur', [text['surah_fatah']!]));
                                },
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // color: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                      Border.all(color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor, width: 1)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ExpansionTile(
                        title: Text(
                          text['after_asar']!,
                          style: TextStyle(
                              color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        backgroundColor: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        collapsedIconColor: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                        collapsedBackgroundColor:
                        darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        iconColor: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.supplicationsBtn,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['supplications']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SupplicationsDetails('asr'));
                                },
                              ),
                              const SizedBox(width: 20,),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.bookIcon,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['surah']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SurahDetails('asr', [text['surah_naba']!]));
                                },
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // color: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                      Border.all(color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor, width: 1)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ExpansionTile(
                        title: Text(
                          text['after_maghrib']!,
                          style: TextStyle(
                              color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        backgroundColor: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        collapsedIconColor: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                        collapsedBackgroundColor:
                        darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        iconColor: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.supplicationsBtn,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['supplications']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SupplicationsDetails('maghrib'));
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.bookIcon,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['surah']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SurahDetails('maghrib', [text['surah_waqia']!]));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // color: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                      Border.all(color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor, width: 1)),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ExpansionTile(
                        title: Text(
                          text['after_isha']!,
                          style: TextStyle(
                              color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        backgroundColor: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        collapsedIconColor: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                        collapsedBackgroundColor:
                        darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                        iconColor: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.supplicationsBtn,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['supplications']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SupplicationsDetails('isha'));
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.only(bottom: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.bookIcon,
                                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                        width: 40,
                                        height: 31,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        text['surah']!,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SurahDetails('isha', [text['surah_mulk']!,text['surah_sajda']!]));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
