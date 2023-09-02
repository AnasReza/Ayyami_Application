import 'package:ayyami/calender_page.dart';
import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/const.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/all_trackers/all_trackers.dart';
import 'package:ayyami/screens/reminder/reminder_screen.dart';
import 'package:ayyami/translation/app_translation.dart';
import 'package:ayyami/widgets/side_bar_bottom_view.dart';
import 'package:ayyami/widgets/side_bar_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../constants/dark_mode_colors.dart';
import '../constants/images.dart';
import '../firebase_calls/user_record.dart';
import '../providers/likoria_timer_provider.dart';
import '../providers/medicine_provider.dart';
import '../providers/menses_provider.dart';
import '../providers/namaz_provider.dart';
import '../providers/post-natal_timer_provider.dart';
import '../providers/pregnancy_timer_provider.dart';
import '../providers/tuhur_provider.dart';
import '../screens/Login_System/sign_in.dart';
import '../screens/about_us/about_us.dart';
import '../screens/history/history.dart';
import '../tracker/likoria_tracker.dart';
import '../tracker/menses_tracker.dart';
import '../tracker/post-natal_tracker.dart';
import '../tracker/pregnancy_tracker.dart';
import '../tracker/tuhur_tracker.dart';
import '../utils/notification.dart';

class SideBar extends StatelessWidget {
  List<String> textList;

  List<String> imageList = [
    AppImages.add_icon,
    AppImages.calenderIcon,
    AppImages.timeIcon,
    AppImages.trackerIcon,
    AppImages.historyIcon,
    AppImages.askIcon
  ];
  String invite, about_us, logout, delete, delete_question, yes, no, deleting;
  bool showComingSoon = false;

  SideBar(this.textList, this.invite, this.about_us, this.logout, this.delete,
      this.delete_question, this.yes, this.no, this.deleting,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (consContext, provider, child) {
        var darkMode = provider.getIsDarkMode;
        var lang = provider.getLanguage;
        var text = AppTranslate().textLanguage[lang];
        return SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              gradient: darkMode!
                  ? AppDarkColors.backgroundGradient
                  : AppColors.backgroundGradient),
          height: double.infinity,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  AppImages.logo,
                  width: 249.6.w,
                  height: 78.36.h,
                  color: darkMode
                      ? AppDarkColors.headingColor
                      : AppColors.headingColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: textList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0 || index == 5) {
                      showComingSoon = true;
                    } else {
                      showComingSoon = false;
                    }
                    return GestureDetector(
                      child: SideBarBox(textList[index], imageList[index],
                          showComingSoon, darkMode, lang!, text!),
                      onTap: () {
                        switch (index) {
                          case 0:
                            print('Add Members');
                            break;
                          case 1:
                            var list = provider.getMensesDateRange;
                            List<HijriDateRange> hijriList = [];
                            for (PickerDateRange dateRange in list) {
                              var mensesStart = dateRange.startDate;
                              var mensesEnd = dateRange.endDate;
                              var mensesStartDiff =
                                  DateTime.now().difference(mensesStart!);
                              var mensesEndDiff =
                                  DateTime.now().difference(mensesEnd!);
                              var mensesHijriStart =
                                  HijriDateTime.now().subtract(mensesStartDiff);
                              var mensesHijriEnd =
                                  HijriDateTime.now().subtract(mensesEndDiff);
                              hijriList.add(HijriDateRange(
                                  mensesHijriStart, mensesHijriEnd));
                            }

                            nextScreen(
                                context,
                                CalenderPage(
                                    darkMode: darkMode,
                                    dateRangeList: provider.getMensesDateRange,
                                    hijriRangeList: hijriList));

                            print('calender');
                            break;
                          case 2:
                            print('Reminders');
                            // Navigator.pushNamed(context, remindersRoute);
                            nextScreen(context, ReminderScreen());
                            break;
                          case 3:
                            nextScreen(context, const AllTrackers());
                            print('Trackers');
                            break;
                          case 4:
                            nextScreen(context, const HistoryScreen());
                            print('Cycle History');
                            break;
                          case 5:
                            print('Ask Mufti');
                            break;
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SideBarBottomView(invite, AppImages.inviteIcon, darkMode),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, const AboutUs());
                  },
                  child: SideBarBottomView(
                      about_us, AppImages.aboutIcon, darkMode),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child:
                      SideBarBottomView(logout, AppImages.logoutIcon, darkMode),
                  onTap: () {
                    var likoriaProvider = Provider.of<LikoriaTimerProvider>(
                        context,
                        listen: false);
                    var mensesProvider =
                        Provider.of<MensesProvider>(context, listen: false);
                    var postProvider =
                        Provider.of<PostNatalProvider>(context, listen: false);
                    var pregProvider =
                        Provider.of<PregnancyProvider>(context, listen: false);
                    var tuhurProvider =
                        Provider.of<TuhurProvider>(context, listen: false);
                    Provider.of<MedicineProvider>(context, listen: false)
                        .resetValue();
                    Provider.of<NamazProvider>(context, listen: false)
                        .resetValue();

                    LikoriaTracker().resetLikoria(likoriaProvider);
                    MensesTracker().resetTracker(mensesProvider);
                    PostNatalTracker().resetTracker(postProvider);
                    PregnancyTracker().resetValue(pregProvider);
                    TuhurTracker().resetValue(tuhurProvider);

                    setHive();
                    SendNotification().cancelAll();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (c) =>
                                const SignIn(signInforDeletion: false)),
                        (route) => false);
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: SideBarBottomView(
                      delete, AppImages.deleteAccountIcon, darkMode),
                  onTap: () {
                    //delete the account here
                    showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: Text(delete),
                            content: Text(delete_question),
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => const SignIn(
                                              signInforDeletion: true)),
                                      (route) => false);
                                },
                                child: Text(yes),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: Text(no),
                              ),
                            ],
                          );
                        });
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("version 2.0.2",
                          style: TextStyle(color: Colors.grey)),
                    ]),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
      },
    );
  }

  void setHive() async {
    var box = await Hive.openBox('aayami');
    box.put('uid', '');
    box.put('login', false);
  }
}
