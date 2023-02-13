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
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: "Supplications",
                fontSize: 45.sp,
                fontWeight: FontWeight.w700,
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
                          'after_fajar'.tr,
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
                                        'supplications'.tr,
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
                                        'surah'.tr,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SurahDetails('fajar', 'surah_yaseen'.tr));
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
                          'after_duhur'.tr,
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
                                        'supplications'.tr,
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
                          'after_asar'.tr,
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
                                        'supplications'.tr,
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
                          'after_maghrib'.tr,
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
                                        'supplications'.tr,
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
                                        'surah'.tr,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SurahDetails('maghrib', 'surah_waqia'.tr));
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
                          'after_isha'.tr,
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
                                        'supplications'.tr,
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
                                        'surah'.tr,
                                        style: TextStyle(
                                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  nextScreen(context, SurahDetails('isha', 'surah_mulk'.tr));
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
