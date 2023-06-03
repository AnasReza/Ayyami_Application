import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../firebase_calls/user_record.dart';
import '../../translation/app_translation.dart';
import '../../utils/notification.dart';
import '../../utils/utils.dart';
import '../../widgets/app_text.dart';
import '../../widgets/customerSwitch1.dart';
import '../../widgets/expanded_remider_container.dart';
import '../../widgets/reminder_container.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool regulationExpanded = true;
  bool sadqaContainerExpanded = true;
  bool saqdaToggle = false, sadqaEdit = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      TextEditingController sadqaController =
          TextEditingController(text: provider.getSadqaAmount.toString());
      var darkMode = provider.getIsDarkMode;
      var lang = provider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      bool showMedicine = provider.getShowMedicine;

      return Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient,
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
                      darkMode ? AppImages.logo_white : AppImages.logo,
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
                          color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                        ),
                      ),
                      SizedBox(width: 150.w),
                      AppText(
                        text: text!['reminders']!,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.w700,
                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ExpandedReminderContainer(
                    text: text,
                    regulationExpanded: regulationExpanded,
                    isSwitched: showMedicine,
                    darkMode: darkMode,
                    lang: lang!,
                  ),
                  SizedBox(
                    height: 54.h,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: 558.w,
                    height: sadqaContainerExpanded ? 234.h : 101.h,
                    decoration: BoxDecoration(
                      color:
                          darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
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
                                      color: darkMode
                                          ? AppDarkColors.headingColor
                                          : AppColors.headingColor,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  CustomSwitch1(
                                    value: saqdaToggle,
                                    onChanged: ((value) {
                                      if (!value) {
                                        SendNotification().sadqaNotificationTime(
                                            int.parse(provider.getSadqaAmount.toString()));
                                      } else {
                                        SendNotification().cancelSadqaNotificationTime();
                                      }
                                      provider.setShowSadqa(value);
                                      UsersRecord().updateShowSadqa(provider.getUid, value);
                                    }),
                                    activeColor: AppColors.black,
                                    darkMode: darkMode,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        sadqaContainerExpanded = !sadqaContainerExpanded;
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
                                    color: darkMode
                                        ? AppDarkColors.headingColor
                                        : AppColors.headingColor,
                                  ),
                                  SizedBox(width: 46.w),
                                  AppText(
                                    text: '\$',
                                    fontSize: 45.sp,
                                    fontWeight: FontWeight.w700,
                                    color: darkMode
                                        ? AppDarkColors.headingColor
                                        : AppColors.headingColor,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 5.h),
                                      child: Visibility(
                                        visible: sadqaEdit,
                                        replacement: SizedBox(
                                          width: 50,
                                          height: 55.sp,
                                          child: TextField(
                                            controller: sadqaController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                            ),
                                            style: TextStyle(color: Colors.white, fontSize: 45.sp),
                                          ),
                                        ),
                                        child: GestureDetector(
                                          child: AppText(
                                            text: provider.getSadqaAmount.toString(),
                                            fontSize: 45.sp,
                                            fontWeight: FontWeight.w700,
                                            color: darkMode
                                                ? AppDarkColors.headingColor
                                                : AppColors.headingColor,
                                          ),
                                          onTap: () {
                                            var amount = sadqaController.text;
                                            if (amount.isNotEmpty) {
                                              setState(() {
                                                sadqaEdit = false;
                                              });
                                            }
                                          },
                                        ),
                                      )),
                                  InkWell(
                                    child: Container(
                                      width: 65.w,
                                      height: 32.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: darkMode
                                                ? AppDarkColors.headingColor
                                                : AppColors.headingColor,
                                            width: 1.w,
                                          )),
                                      child: Center(
                                        child: AppText(
                                          text: "Done",
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: darkMode
                                              ? AppDarkColors.headingColor
                                              : AppColors.headingColor,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        sadqaEdit = true;
                                      });
                                      String sadqaString = sadqaController.text;
                                      if (sadqaString.isEmpty) {
                                        sadqaString = '0';
                                      }
                                      provider.setSadqaAmount(int.parse(sadqaString));
                                    },
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
                                  color: darkMode
                                      ? AppDarkColors.headingColor
                                      : AppColors.headingColor,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    sadqaContainerExpanded = !sadqaContainerExpanded;
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
                    isSwitched: provider.getShowCycle,
                    darkMode: darkMode,
                    returnvalue: (value) {
                      try {
                        if (!value) {
                          var startTime = provider.getLastMenses.toDate();
                          var map = Utils().assumptionOfMenses(provider, startTime);
                          DateTime startDateTime = DateTime.parse(map['start'].toString());

                          SendNotification().cycleNotificationTime(startDateTime);
                          provider.setShowCycle(true);
                          UsersRecord().updateShowCycle(provider.getUid, true);
                        } else {
                          SendNotification().cancelCycleNotificationTime();
                          provider.setShowCycle(false);
                          UsersRecord().updateShowCycle(provider.getUid, false);
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                  ),

                  // SizedBox(height: 48.h),
                  // ReminderSwitchContainerWidget(
                  //   title: text['prayer_reminder']!,
                  //   isSwitched: false,
                  //   darkMode: darkMode,
                  // ),
                  // SizedBox(height: 48.h),
                  // ReminderSwitchContainerWidget(
                  //   title: text['supplication_reminder']!,
                  //   isSwitched: false,
                  //   darkMode: darkMode,
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
