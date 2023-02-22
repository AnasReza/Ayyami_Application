import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../translation/app_translation.dart';
import '../widgets/app_text.dart';
import '../widgets/customerSwitch1.dart';
import '../widgets/expanded_remider_container.dart';
import '../widgets/reminder_container.dart';

class MedicineReminderScreen extends StatefulWidget {
  const MedicineReminderScreen({Key? key}) : super(key: key);

  @override
  State<MedicineReminderScreen> createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen> {
  bool regulationExpanded = true;
  bool sadqaContainerExpanded = true;
  bool saqdaToggle = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c,provider,child){
      var darkMode=provider.getIsDarkMode;
      var lang=provider.getLanguage;
      var text=AppTranslate().textLanguage[lang];

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: darkMode?AppDarkColors.backgroundGradient:AppColors.backgroundGradient,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 70.w,
              right: 70.w,
              top: 80.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      darkMode?AppImages.logo_white:AppImages.logo,
                      width: 249.6.w,
                      height: 78.4.h,
                    ),
                  ),
                  SizedBox(height: 70.6.h),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(
                          AppImages.backIcon,
                          width: 49.w,
                          height: 34.h,
                          color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                        ),
                      ),
                      SizedBox(width: 150.w),
                      AppText(
                        text: text!['reminders']!,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.w700,
                        color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,

                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ExpandedReminderContainer(text: text,
                      regulationExpanded: regulationExpanded,darkMode: darkMode,),
                  SizedBox(
                    height: 54.h,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: 558.w,
                    height: sadqaContainerExpanded ? 234.h : 101.h,
                    decoration: BoxDecoration(
                      color: const Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                        width: 1.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0x1e1f3d73),
                            offset: const Offset(0, 12),
                            blurRadius: 40.r,
                            spreadRadius: 0)
                      ],
                    ),
                    child: sadqaContainerExpanded
                        ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              text['sadqa_reminder']!,
                              style: TextStyle(
                                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            CustomSwitch1(
                              value: saqdaToggle,
                              onChanged: ((value) {
                                setState(() {
                                  value = saqdaToggle;
                                });
                              }),
                              activeColor: AppColors.black,
                              darkMode: darkMode,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  sadqaContainerExpanded =
                                  !sadqaContainerExpanded;
                                });
                              },
                              child: SvgPicture.asset(
                                AppImages.downIcon,
                                height: 20.h,
                                width: 10.w,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 55.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: text['sadqa_amount']!,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                            ),
                            SizedBox(width: 46.w),
                            AppText(
                              text: '\$',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: AppText(
                                text: '50',
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w700,
                                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                              ),
                            ),
                            SizedBox(width: 200.w),
                            InkWell(
                              child: Container(
                                width: 65.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                                      width: 1.w,
                                    )),
                                child: Center(
                                  child: AppText(
                                    text: "Done",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text['sadqa_reminder']!,
                          style: TextStyle(
                            color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,

                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              sadqaContainerExpanded =
                              !sadqaContainerExpanded;
                            });
                          },
                          child: SvgPicture.asset(
                            AppImages.arrow_right,
                            height: 36.h,
                            width: 36.w,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 71.h),
                  ReminderSwitchContainerWidget(
                    title: text['cycle_reminder']!,
                    isSwitched: false,
                    darkMode: darkMode,
                  ),
                  SizedBox(height: 48.h),
                  ReminderSwitchContainerWidget(
                    title: text['prayer_reminder']!,
                    isSwitched: false,
                    darkMode: darkMode,
                  ),
                  SizedBox(height: 48.h),
                  ReminderSwitchContainerWidget(
                    title: text['supplication_reminder']!,
                    isSwitched: false,
                    darkMode: darkMode,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
