import 'package:ayyami/constants/surah_text.dart';
import 'package:ayyami/widgets/surah_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/dark_mode_colors.dart';
import '../../constants/images.dart';
import '../../providers/user_provider.dart';

class SurahDetails extends StatelessWidget {
  String prayerTime;
  List<String> heading;
  SurahDetails(this.prayerTime, this.heading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      var surah = SurahText().getSurah(prayerTime);
      var darkMode = provider.getIsDarkMode;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: darkMode ? AppDarkColors.white : AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: darkMode ? AppColors.white : AppDarkColors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: SvgPicture.asset(
            darkMode ? AppImages.logo_white : AppImages.logo,
            width: 249.6.w,
            height: 78.4.h,
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                gradient:
                    darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient),
            child: ListView.builder(
                itemCount: surah!.length,
                itemBuilder: (listContext, index) {
                  return SurahView(darkMode, surah![index]['surah']!, heading[index]);
                })),
      );
    });
  }
}
