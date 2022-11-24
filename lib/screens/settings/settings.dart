import 'package:ayyami/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../dialog/rate_dialog.dart';
import '../../widgets/app_text.dart';
import '../../widgets/category_box.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: "Settings",
              fontSize: 45.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 20,
            ),
            //CHANGE LOCATION
            CategoryBox(
              categoryName: 'change_location'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              comingSoon: false,
              showDate: false,
            ),
            const SizedBox(
              height: 20,
            ),
            //CHANGE Language
            CategoryBox(
              categoryName: 'change_language'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              comingSoon: false,
              showDate: false,
            ),
            const SizedBox(
              height: 20,
            ),
            //CGANGE THEME
            CategoryBox(
              categoryName: 'change_theme'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              comingSoon: true,
              isSelected: false,
              showDate: false,
            ),
            const SizedBox(
              height: 20,
            ),
            //TRACKER FACE
            CategoryBox(
              categoryName: 'change_tracker_face'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              comingSoon: true,
              showDate: false,
            ),
            const SizedBox(
              height: 20,
            ),
            //DARK MODE
            CategoryBox(
              categoryName: 'dark_mode'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              showDate: false,
              comingSoon: false,
            ),
            const SizedBox(
              height: 20,
            ),
            //BUY PREMIUM
            CategoryBox(
              categoryName: 'buy_premium'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              comingSoon: false,
              showDate: false,
            ),
            const SizedBox(
              height: 20,
            ),
            //RATE APP
            GestureDetector(child: CategoryBox(
              categoryName: 'rate_app'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              comingSoon: false,
              showDate: false,
            ),onTap: (){
              showDialog(context: context, builder: (dialogContext){
                return RateDialog();
              },useSafeArea: true);
            },),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
