import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/screens/prayer/prayer_timing.dart';
import 'package:ayyami/screens/profile/profile.dart';
import 'package:ayyami/screens/settings/settings.dart';
import 'package:ayyami/screens/supplications/supplications.dart';
import 'package:ayyami/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/images.dart';
import '../navigation/custom_bottom_nav.dart';
import '../navigation/custom_fab.dart';
import 'home/home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  final int _cIndex = 0;
  int widgetIndex = 2;
  List<Widget> widgetList = [ProfilePage(), Supplications(), HomeScreen(), PrayerTiming(), Settings()];
  final GlobalKey<ScaffoldState> _key=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(padding: EdgeInsets.only(left: 10),child: InkWell(
          onTap: () {
            _key.currentState!.openDrawer();
            // Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTiming()));
          },
          child: SvgPicture.asset(
            AppImages.menuIcon,
            width: 44.w,
            height: 38.h,
          ),
        ),),
        leadingWidth: 30,
        title: SvgPicture.asset(
          AppImages.logo,
          width: 249.6.w,
          height: 78.36.h,
        ),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       _key.currentState!.openDrawer();
        //       // Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTiming()));
        //     },
        //     child: SvgPicture.asset(
        //       AppImages.menuIcon,
        //       width: 44.w,
        //       height: 38.h,
        //     ),
        //   ),
        // ],
      ),
      body: Container(decoration:BoxDecoration(gradient: AppColors.backgroundGradient),child: widgetList[widgetIndex],),
      bottomNavigationBar: CustomBottomNav(
          cIndex: _cIndex,
          tappingIndex: (index) {
            setState(() {
              widgetIndex = index;
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FAB(tappingIndex: (index) {
        setState(() {
          widgetIndex = index;
        });
      }),
      drawer: SideBar(),
    );
  }
}
