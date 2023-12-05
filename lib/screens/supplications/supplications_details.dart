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
      var list = getDuaMap(prayerTime, lang!);

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
              gradient: darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient),
          child: ListView.builder(
              itemCount: list?.length,
              itemBuilder: (listContext, index) {
                print('${list![index]['dua']!} ==dua\n');
                print('${list![index]['description']!}==des\n');
                print('${list![index]['heading']!}==heading\n');
                return SupplicationView(darkMode, list![index]['heading']!, list![index]['dua']!,
                    list![index]['times']!, list![index]['description']!);
              }),
        ),
      );
    });
  }
}
