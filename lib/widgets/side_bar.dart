import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/widgets/side_bar_bottom_view.dart';
import 'package:ayyami/widgets/side_bar_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/images.dart';

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
  bool showComingSoon=false;

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
                if(index==5){
                  showComingSoon=true;
                }else{
                  showComingSoon=false;
                }
                return SideBarBox(textList[index], imageList[index],showComingSoon);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SideBarBottomView('Invite Friends', AppImages.inviteIcon),
            const SizedBox(
              height: 20,
            ),
            SideBarBottomView('About Us', AppImages.aboutIcon),
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
