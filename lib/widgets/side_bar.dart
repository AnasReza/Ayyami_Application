import 'package:ayyami/calender_page.dart';
import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/const.dart';
import 'package:ayyami/screens/all_trackers/all_trackers.dart';
import 'package:ayyami/widgets/side_bar_bottom_view.dart';
import 'package:ayyami/widgets/side_bar_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/images.dart';
import '../constants/routes.dart';
import '../screens/about_us/about_us.dart';
import '../screens/history.dart';

class SideBar extends StatelessWidget {
  List<String> textList = ['Add Members', 'Calender', 'Reminders', 'Trackers', 'Cycle History', 'Ask Mufti'];
  List<String> imageList = [
    AppImages.add_icon,
    AppImages.calenderIcon,
    AppImages.timeIcon,
    AppImages.trackerIcon,
    AppImages.historyIcon,
    AppImages.askIcon
  ];
  bool showComingSoon = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      height: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              AppImages.logo,
              width: 249.6.w,
              height: 78.36.h,
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: textList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
              itemBuilder: (BuildContext context, int index) {
                if (index == 5) {
                  showComingSoon = true;
                } else {
                  showComingSoon = false;
                }
                return GestureDetector(
                  child: SideBarBox(textList[index], imageList[index], showComingSoon),
                  onTap: () {
                    switch (index) {
                      case 0:
                        print('Add Members');
                        break;
                      case 1:
                        nextScreen(context, CalenderPage());
                        print('calender');
                        break;
                      case 2:
                        print('Reminders');
                        Navigator.pushNamed(context, remindersRoute);
                        break;
                      case 3:
                        nextScreen(context, AllTrackers());
                        print('Trackers');
                        break;
                      case 4:
                        nextScreen(context, HistoryScreen());
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
            SideBarBottomView('Invite Friends', AppImages.inviteIcon),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(onTap: (){nextScreen(context, AboutUs());},child: SideBarBottomView('About Us', AppImages.aboutIcon),),

            const SizedBox(
              height: 20,
            ),
            SideBarBottomView('Logout', AppImages.logoutIcon),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}
