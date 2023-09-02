import 'package:ayyami/constants/const.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/habit_provider.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/providers/pregnancy_timer_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/tracker/post-natal_tracker.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:ayyami/widgets/pregnancy_timer_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../dialog/timer_date_time.dart';
import '../../providers/menses_provider.dart';
import '../../providers/prayer_provider.dart';
import '../../tracker/pregnancy_tracker.dart';
import '../../translation/app_translation.dart';
import '../../widgets/category_box.dart';
import '../../widgets/menses_timer_box.dart';
import '../../widgets/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool regulationExpanded = false;
  String lastCycleDate = '', regulationMessage = '';
  String uid = '';
  int lastMensesDays = 0,
      lastMensesHours = 0,
      lastMensesMinutes = 0,
      lastMensesSeconds = 0;
  int lastTuhurDays = 0,
      lastTuhurHours = 0,
      lastTuhurMinutes = 0,
      lastTuhurSeconds = 0;

  bool mensesStart = false, tuhurStart = false;
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    print("======HOME SCREEN======\n");
    final provider = context.read<UserProvider>();
    uid = provider.getUid;

    // provider.callNotification();
    // provider.fetchTimerAndCalculate();
    // Future.delayed(const Duration(microseconds: 100),(){
    //   provider.initPrayerTiming(context);
    // });

    WidgetsBinding.instance.addObserver(this);
    getLastTuhur(uid, provider);
    getLastMenses(uid, provider);
    startMensesAgain(uid, provider);
    startTuhurAgain(uid, provider);
    if (provider.getMarried == 'Married' && provider.getArePregnant) {
      getLastPregnancy(uid, provider);
    }
  }

  void getLastTuhur(String uid, UserProvider pro) {
    FirebaseFirestore.instance
        .collection('tuhur')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      print("Getting Last Tuhur Record=>");
      for (int x = 0; x < docList.length; x++) {
        var doc = docList[x];
        print(doc.id);
        Timestamp startTime = doc.get('start_date');
        bool non_menstrual_bleeding = doc.get('non_menstrual_bleeding');
        //if menstrual=true bleeding or nonmenstrual = false
        if (non_menstrual_bleeding == false) {
          try {
            int days = doc.get('days');
            int hour = doc.get('hours');
            int minute = doc.get('minutes');
            int seconds = doc.get('seconds');
            setState(() {
              //change minutes and seconds to days and hours
              lastTuhurDays = doc.get('days');
              lastTuhurHours = doc.get('hours');
            });
            print('${doc.id}==tuhur ID ');
            pro.setLastTuhur(startTime);
            pro.setLastTuhurTime(days, hour, minute, seconds);
            print('${doc.id}=uid from tuhur collection');
            break;
          } catch (e) {
            print("error at ${doc.id}: $e");
          }
        }
      }
    });
  }

  void getLastMenses(String uid, UserProvider pro) {
    FirebaseFirestore.instance
        .collection('menses')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      print("=======Getting Last Menses Record=>");
      for (var doc in docList) {
        print('${doc.id}=uid from menses collection');
        Timestamp startTime = doc.get('start_date');
        bool fromMiscarriageOrDnc = doc.get('fromMiscarriageOrDnc');
        try {
          var lang = pro.getLanguage;
          Timestamp endTime = doc.get('end_time');
          DateTime startDate = startTime.toDate();
          int days = doc.get('days');
          int hour = doc.get('hours');
          int minute = doc.get('minutes');
          int seconds = doc.get('seconds');
          intl.DateFormat format = intl.DateFormat('dd MMMM yyyy');
          intl.DateFormat monthFormat = intl.DateFormat('MMMM');
          if (lang == 'ur') {
            lastCycleDate =
                '${startDate.day} ${getUrduMonthNames(monthFormat.format(startDate))} ${startDate.year}';
          } else {
            lastCycleDate = format.format(startDate);
          }
          setState(() {
            //change minutes and seconds to days and hours
            lastMensesDays = doc.get('days');
            lastMensesHours = doc.get('hours');
            print(lastMensesDays);
          });
          pro.setLastMenses(startTime);
          pro.setLastMensesEnd(endTime);
          pro.setLastMensesTime(days, hour, minute, seconds);

          var mensesProvider = context.read<MensesProvider>();
          mensesProvider.setStartTime(startTime);
          mensesProvider.setMensesID(doc.id);
          mensesProvider.setFromMiscarriageOrDnc(fromMiscarriageOrDnc);

          break;
        } catch (e) {
          print("ex---- $e");
        }
      }
    });
  }

  void startMensesAgain(String uid, UserProvider pro) {
    FirebaseFirestore.instance
        .collection('menses')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true) //latest
        .limit(1)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      print("Getting Start Menses Again Record=>");
      for (var doc in docList) {
        Timestamp startTime = doc.get('start_date');
        bool fromMiscarriageOrDnc = doc.get('fromMiscarriageOrDnc');
        var mensesProvider = context.read<MensesProvider>();
        try {
          doc.get('end_time');
          //if end time doesnt exists, start the timer
          mensesProvider.setTimerStart(false);
          MensesTracker().resetTracker(mensesProvider);
          var up = context.read<UserProvider>();
          print("user provider: $up ${doc.id}");
        } catch (e) {
          //if end time doesnt exists, start the timer
          var timerStart = mensesProvider.getTimerStart;
          if (!timerStart && mensesProvider.getMensesID.isNotEmpty) {
            mensesProvider.setMensesID(doc.id);
            mensesProvider.setTimerStart(true);
            mensesProvider.setStartTime(startTime);
            mensesProvider.setFromMiscarriageOrDnc(fromMiscarriageOrDnc);

            var now = DateTime.now();
            var diff = now.difference(startTime.toDate());
            MensesTracker().startMensesTimerAgain(
                mensesProvider, startTime, diff.inMilliseconds);
          }
        }
      }
    });
  }

  void startTuhurAgain(String uid, UserProvider pro) {
    FirebaseFirestore.instance
        .collection('tuhur')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .limit(1) //TODO previous: no limit(1)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      print("Getting Start Tuhur Again =>");
      for (int x = 0; x < docList.length; x++) {
        var doc = docList[x];
        print(doc.id);
        Timestamp startTime = doc.get('start_date');
        int tuhurFrom = doc.get('from');
        var tuhurProvider = context.read<TuhurProvider>();
        try {
          doc.get('end_time');
          doc.get('days');
          tuhurProvider.resetValue();

          // int hour = doc.get('hours');
          // int minute = doc.get('minutes');
          // int seconds = doc.get('seconds');
        } catch (e) {
          print('$e error in tuhur');
          print('${doc.id} tuhur id that is not finished');
          tuhurProvider.setTuhurID(doc.id);
          tuhurProvider.setTimerStart(true);
          tuhurProvider.setFrom(tuhurFrom);
          tuhurProvider.setStartTime(startTime);
          var now = DateTime.now();
          var diff = now.difference(startTime.toDate());
          TuhurTracker()
              .startTuhurTimerAgain(tuhurProvider, diff.inMilliseconds);
          break;
        }
      }
    });
  }

  void getLastPregnancy(String uid, UserProvider pro) {
    FirebaseFirestore.instance
        .collection('pregnancy')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      for (var doc in docList) {
        Timestamp startTime = doc.get('start_date');
        if (!doc.data().containsKey('end_time')) {
          var pregnancyProvider = context.read<PregnancyProvider>();
          pregnancyProvider.setStartTime(startTime);
          pregnancyProvider.setPregnancyID(doc.id);
          break;
        }
      }
    });
  }

  void getLastPostNatal(String uid, UserProvider pro) {
    var postNatalProvider = context.read<PostNatalProvider>();
    var userProvider = context.read<UserProvider>();
    FirebaseFirestore.instance
        .collection('post-natal')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
      var docList = event.docs;
      for (var doc in docList) {
        Timestamp startTime = doc.get('start_date');
        try {
          doc.get('end_time');
          postNatalProvider.setTimerStart(false);
          PostNatalTracker().resetTracker(postNatalProvider);
        } catch (e) {
          var timerStart = postNatalProvider.getTimerStart;
          if (!timerStart) {
            postNatalProvider.setTimerStart(true);
            postNatalProvider.setStartTime(startTime);
            postNatalProvider.setPostNatalID(doc.id);
            var now = DateTime.now();
            var diff = now.difference(startTime.toDate());

            PostNatalTracker().startPostNatalAgain(postNatalProvider,
                userProvider, startTime, diff.inMilliseconds);
            break;
          }
        }
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
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      print("save timer data in shared");
      provider.saveTimerTimeinShared();
    } else if (state == AppLifecycleState.resumed) {
      print("fetching timer val calulating");
      provider.fetchTimerAndCalculate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (consumerContext, userProvider, child) {
      final provider = context.read<PrayerProvider>();
      final tuhurProvider = Provider.of<TuhurProvider>(context, listen: false);
      darkMode = userProvider.getIsDarkMode;
      var lang = userProvider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      mensesStart = context.read<MensesProvider>().isTimerStart;
      tuhurStart = context.read<TuhurProvider>().isTimerStart;
      print('$mensesStart==mensesStart...........$tuhurStart=tuhurstart');
      return Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: darkMode
                ? AppDarkColors.backgroundGradient
                : AppColors.backgroundGradient),
        child: Padding(
          padding: EdgeInsets.only(
            left: 70.w,
            right: 70.w,
            top: 21.h,
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              Directionality(
                textDirection:
                    lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      text:
                          "${provider.gorgeonTodayDateFormated}\n${provider.hijriDateFormated}",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: darkMode
                          ? AppDarkColors.headingColor
                          : AppColors.headingColor,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        text: mensesStart
                            ? text!['menstrual_bleeding']!
                            : userProvider.getArePregnant
                                ? text!['pregnancy']! + text['tracker']!
                                : text!['menstrual_bleeding']!,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: darkMode
                            ? AppDarkColors.headingColor
                            : AppColors.headingColor,
                      ),
                    ),
                  ],
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
                        text: text['recent_regulation']!,
                        color: AppColors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // regulationExpanded = !regulationExpanded;
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
                  ? Directionality(
                      textDirection:
                          lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                      child: Column(
                        children: [
                          Container(
                            width: 558.w,
                            height: 120.h,
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
                              padding: EdgeInsets.only(
                                  left: 30.w, right: 5.w, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AppImages.safeIcon),
                                  SizedBox(width: 25.8.w),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.63,
                                      child: SingleChildScrollView(
                                        child: AppText(
                                          text: regulationMessage,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                  : Container(),

              userProvider.getMarried == 'Married' &&
                      userProvider.getArePregnant
                  ? const PregnancyTimerBox()
                  : Container(),

              !userProvider.getArePregnant
                  ? TimerBox(
                      mensis: (value, message) {
                        setState(() {
                          regulationExpanded = value;
                          regulationMessage = message;
                        });
                      },
                      islamicMonth: provider.hijriDateFormated)
                  : Container(),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: AppText(
                  text: text['last_cycle']!,
                  fontSize: 30.sp,
                  textDirection:
                      lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                  fontWeight: FontWeight.w700,
                  color: darkMode
                      ? AppDarkColors.headingColor
                      : AppColors.headingColor,
                ),
              ),

              SizedBox(height: 20.h),
              AppText(
                text: lastCycleDate,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                textDirection:
                    lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                color: AppColors.grey,
              ),
              SizedBox(height: 15.h),
              // tuhur box
              Directionality(
                textDirection:
                    lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                child: CategoryBox(
                  categoryName: text['tuhur']!,
                  days: lastTuhurDays,
                  hours: lastTuhurHours,
                  checkbox: false,
                  showDate: true,
                  isSelected: false,
                  comingSoon: false,
                  text: text,
                  darkMode: darkMode,
                  textDirection:
                      lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
              // menses box
              SizedBox(height: 41.h),
              Directionality(
                textDirection:
                    lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                child: CategoryBox(
                  categoryName: text['menses']!,
                  days: lastMensesDays,
                  hours: lastMensesHours,
                  checkbox: false,
                  showDate: true,
                  comingSoon: false,
                  text: text,
                  isSelected: false,
                  darkMode: darkMode,
                  textDirection:
                      lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
              const SizedBox(height: 50),
              // I saw a spot today
              Visibility(
                visible: !tuhurProvider.getSpot && !mensesStart,
                child: GestureDetector(
                  onTap: () {
                    var currentID = tuhurProvider.getTuhurID;
                    print("clicked ${currentID}");
                    tuhurProvider.setSpot(true);
                    TuhurRecord.updateSpot(currentID, true);
                    toast_notification().toast_message("Spot Marked.");
                  },
                  child: Directionality(
                    textDirection:
                        lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      margin: const EdgeInsets.only(left: 50, right: 50),
                      decoration: BoxDecoration(
                          gradient: AppColors.bgPinkishGradient,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Wrap(
                          spacing: 20,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.dropIcon,
                              width: 28.sp,
                              height: 40.sp,
                            ),
                            Text(
                              text['spot_today']!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // I am expecting
              Visibility(
                visible: userProvider.getMarried == 'Married' &&
                    !userProvider.getArePregnant,
                child: GestureDetector(
                  child: Directionality(
                    textDirection:
                        lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      margin: const EdgeInsets.only(left: 50, right: 50),
                      decoration: BoxDecoration(
                          gradient: AppColors.bgPinkishGradient,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Wrap(
                          spacing: 20,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.dropIcon,
                              width: 28.sp,
                              height: 40.sp,
                            ),
                            Text(
                              text['expecting_a_child']!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (tuhurStart) {
                      showStartDialog(text);
                    } else {
                      toast_notification()
                          .toast_message(text['when_pregnancy_start']!);
                    }
                  },
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }

  // Any changes made here should also be made in PregnancyTimerBox:191
  void showStartDialog(Map<String, String> text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          return DialogDateTime(
            getDateTime: (date, time) {
              int year = date.year;
              int month = date.month;
              int day = date.day;
              int hour = time.hour;
              int minute = time.minute;
              DateTime startDate = DateTime(year, month, day, hour, minute);
              var dateString =
                  intl.DateFormat.yMEd().add_jms().format(startDate);
              print('$dateString  == dateString');
              var userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              var provider =
                  Provider.of<PregnancyProvider>(context, listen: false);
              var tuhurProvider =
                  Provider.of<TuhurProvider>(context, listen: false);

              PregnancyTracker().startPregnancyTimer(
                  userProvider,
                  provider,
                  userProvider.getUid,
                  tuhurProvider,
                  Timestamp.fromDate(startDate));

              Navigator.pop(dialogContext);
            },
            darkMode: darkMode,
            text: text,
          );
        });
  }
}
