// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:ayyami/constants/images.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/prayer/prayer_timing.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../navigation/custom_bottom_nav.dart';
import '../../navigation/custom_fab.dart';
import '../../providers/prayer_provider.dart';
import '../../services/local_noti_service.dart';
import '../../widgets/category_box.dart';
import '../../widgets/menses_timer_box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final int _cIndex = 0;
  bool regulationExpanded = false;
  String lastCycleDate = '', regulationMessage = '';
  String uid = '';
  int lastMensesDays = 0, lastMensesHours = 0, lastMensesMinutes = 0, lastMensesSeconds = 0;
  int lastTuhurDays = 0, lastTuhurHours = 0, lastTuhurMinutes = 0, lastTuhurSeconds = 0;

  @override
  void initState() {
    super.initState();
    final provider = context.read<UserProvider>();
    uid = provider.getUid!;
    // provider.callNotification();
    // provider.fetchTimerAndCalculate();
    // Future.delayed(const Duration(microseconds: 100),(){
    //   provider.initPrayerTiming(context);
    // });
    WidgetsBinding.instance.addObserver(this);
    getLastTuhur(uid, provider);
    getLastMenses(uid, provider);
  }

  getLastTuhur(String uid, UserProvider pro) {
    FirebaseFirestore.instance
        .collection('tuhur')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      for (int x = 0; x < docList.length; x++) {
        var doc = docList[x];
        bool non_menstrual_bleeding = doc.get('non_menstrual_bleeding');
        if (!non_menstrual_bleeding) {
          try {
            Timestamp startTime = doc.get('start_date');

            int days = doc.get('days');
            int hour = doc.get('hours');
            int minute = doc.get('minutes');
            int seconds = doc.get('seconds');
            setState(() {
              //change minutes and seconds to days and hours
              lastTuhurDays = doc.get('days');
              lastTuhurHours = doc.get('hours');
            });
            print('${doc.id}==menses');
            pro.setLastTuhur(startTime);
            pro.setLastTuhurTime(days, hour, minute, seconds);
            print('${doc.id}=uid from menses collection');
            break;
          } catch (e) {}
        }
      }
    });
  }

  getLastMenses(String uid, UserProvider pro) {
    FirebaseFirestore.instance
        .collection('menses')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .limit(1)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      for (var doc in docList) {
        Timestamp startTime = doc.get('start_date');
        Timestamp endTime = doc.get('end_time');
        DateTime startDate = startTime.toDate();
        int days = doc.get('days');
        int hour = doc.get('hours');
        int minute = doc.get('minutes');
        int seconds = doc.get('seconds');

        DateFormat format = DateFormat('dd MMMM yyyy');
        setState(() {
          //change minutes and seconds to days and hours
          lastMensesDays = doc.get('days');
          lastMensesHours = doc.get('hours');
          lastCycleDate = format.format(startDate);
        });
        pro.setLastMenses(startTime);
        pro.setLastMensesEnd(endTime);
        pro.setLastMensesTime(days, hour, minute, seconds);
        print('${doc.id}=uid from menses collection');
      }
    });
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
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      print("save timer data in shared");
      provider.saveTimerTimeinShared();
    } else if (state == AppLifecycleState.resumed) {
      print("fetching timer val calulating");
      provider.fetchTimerAndCalculate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (consumerContext, userProvider, child) {
      final provider = context.read<PrayerProvider>();
      return Scaffold(
        // bottomNavigationBar: CustomBottomNav(cIndex: _cIndex),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: const FAB(),
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Container(
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
                                // regulationExpanded = !regulationExpanded;
                              });
                            },
                            child: SvgPicture.asset(
                              regulationExpanded ? AppImages.upIcon : AppImages.downIcon,
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
                              height: 550.h,
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
                                padding: EdgeInsets.only(left: 30.w, right: 5.w,top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    SvgPicture.asset(AppImages.safeIcon),
                                    SizedBox(width: 25.8.w),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.63,
                                      child: SingleChildScrollView(child: AppText(
                                        text: regulationMessage,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  TimerBox(mensis: (value, message) {
                    setState(() {
                      regulationExpanded = value;
                      regulationMessage = message;
                    });
                  }),
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
                    text: lastCycleDate,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 15.h),
                  CategoryBox(
                    categoryName: 'Tuhur',
                    days: lastTuhurDays,
                    hours: lastTuhurHours,
                    checkbox: false,
                    showDate: true,
                    isSelected: false,
                    comingSoon: false,
                  ),
                  SizedBox(height: 41.h),
                  CategoryBox(
                    categoryName: 'Mensis',
                    days: lastMensesDays,
                    hours: lastMensesHours,
                    checkbox: false,
                    showDate: true,
                    comingSoon: false,
                    isSelected: false,
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
