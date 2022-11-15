// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:ayyami/constants/images.dart';
import 'package:ayyami/screens/prayer/prayer_timing.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../navigation/custom_bottom_nav.dart';
import '../../navigation/custom_fab.dart';
import '../../providers/prayer_provider.dart';
import '../../services/local_noti_service.dart';
import '../../widgets/category_box.dart';
import '../../widgets/timer_box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  final int _cIndex = 0;
  bool regulationExpanded = true;

  @override
  void initState() {
    super.initState();
    final provider = context.read<PrayerProvider>();
    // provider.callNotification();
    // provider.fetchTimerAndCalculate();
    // Future.delayed(const Duration(microseconds: 100),(){
    //   provider.initPrayerTiming(context);
    // });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    context.read<PrayerProvider>().stopTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final provider = context.read<PrayerProvider>();
    print("Starte $state");
    if(state == AppLifecycleState.paused || state == AppLifecycleState.detached){
      print("save timer data in shared");
      provider.saveTimerTimeinShared();

    }else if(state == AppLifecycleState.resumed){
      print("fetching timer val calulating");
      provider.fetchTimerAndCalculate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PrayerProvider>();
    return Scaffold(
      // bottomNavigationBar: CustomBottomNav(cIndex: _cIndex),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: const FAB(),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          decoration:
              const BoxDecoration(gradient: AppColors.backgroundGradient),
          child: Padding(
            padding: EdgeInsets.only(
              left: 70.w,
              right: 70.w,
              top: 21.h,
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     SvgPicture.asset(
                //       AppImages.logo,
                //       width: 249.6.w,
                //       height: 78.36.h,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTiming()));
                //       },
                //       child: SvgPicture.asset(
                //         AppImages.menuIcon,
                //         width: 44.w,
                //         height: 38.h,
                //       ),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 440.w, top: 60.h),
                  child: AppText(
                    text: "${provider.gorgeonTodayDateFormated}\n${provider.hijriDateFormated}",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    text: "  Menstrual bleeding",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 14.h),
                Container(
                  width: 558.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: AppColors.headingColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0.r),
                      topRight: Radius.circular(10.0.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 29.w,
                      vertical: 15.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          text: "Recent Regulation",
                          color: AppColors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              regulationExpanded = !regulationExpanded;
                            });
                          },
                          child: SvgPicture.asset(
                            regulationExpanded
                                ? AppImages.upIcon
                                : AppImages.downIcon,
                            // width: 17.6.w,
                            // height: 8.8.h,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                regulationExpanded
                    ? Column(
                        children: [
                          Container(
                            width: 558.w,
                            height: 94.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.headingColor,
                                width: 1.w,
                              ),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1e1f3d73),
                                  offset: Offset(0, 12),
                                  blurRadius: 40,
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 72.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.safeIcon),
                                  SizedBox(width: 25.8.w),
                                  AppText(
                                    text:
                                        "You are Pak Now you can perform salah.",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const TimerBox()
                        ],
                      )
                    : const TimerBox(),
                SizedBox(height: 117.6.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    text: "  Last Cycle",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20.h),
                AppText(
                  text: "5 September 2022",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
                SizedBox(height: 15.h),
                CategoryBox(
                  categoryName: 'Tuhur',
                  days: 21,
                  hours: 12,
                  checkbox: false,
                  isSelected: false,
                ),
                SizedBox(height: 41.h),
                CategoryBox(
                  categoryName: 'Mensis',
                  days: 4,
                  hours: 8,
                  checkbox: false,
                  isSelected: false,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
