import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/const.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/supplication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants/images.dart';
import '../../translation/app_translation.dart';

class SupplicationsDetails extends StatelessWidget {
  String prayerTime = '';

  SupplicationsDetails(this.prayerTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {

      var darkMode = provider.getIsDarkMode;
      var lang = provider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      var list = getDuaMap(prayerTime,lang!);

      return Scaffold(
        appBar: AppBar(
          backgroundColor: darkMode ? AppDarkColors.white : AppColors.white,
          elevation: 0,
          title: SvgPicture.asset(
            darkMode ? AppImages.logo_white : AppImages.logo,
            width: 249.6.w,
            height: 78.4.h,
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: ListView.builder(
              itemCount: list?.length,
              itemBuilder: (listContext, index) {
                return SupplicationView(darkMode, list![index]['heading']!, list![index]['dua']!,
                    list![index]['times']!, list![index]['description']!);
              }),
        ),
      );
    });
  }
}
