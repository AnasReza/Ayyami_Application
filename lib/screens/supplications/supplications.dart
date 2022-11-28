import 'package:ayyami/constants/const.dart';
import 'package:ayyami/screens/supplications/supplications_details.dart';
import 'package:ayyami/widgets/category_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/app_text.dart';

class Supplications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SupplicationsState();
  }
}

class SupplicationsState extends State<Supplications> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: "Supplications",
              fontSize: 45.sp,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(child:CategoryBox(
              categoryName: 'after_fajar'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              showDate: false,
              comingSoon: false,
            ), onTap: (){
              nextScreen(context, SupplicationsDetails('fajar'));
            },),

            const SizedBox(
              height: 20,
            ),
            GestureDetector(child:CategoryBox(
              categoryName: 'after_duhur'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              comingSoon: false,
              showDate: false,
            ), onTap: (){
              nextScreen(context, SupplicationsDetails('zuhur'));
            },),

            const SizedBox(
              height: 20,
            ),
            GestureDetector(child: CategoryBox(
              categoryName: 'after_asar'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              showDate: false,
              comingSoon: false,
            ),onTap: (){
              nextScreen(context, SupplicationsDetails('asr'));
            },),

            const SizedBox(
              height: 20,
            ),
            GestureDetector(child: CategoryBox(
              categoryName: 'after_maghrib'.tr,
              days: 21,
              hours: 12,
              comingSoon: false,
              checkbox: false,
              isSelected: false,
              showDate: false,
            ),onTap: (){
              nextScreen(context, SupplicationsDetails('maghrib'));
            },),

            const SizedBox(
              height: 20,
            ),
            GestureDetector(child: CategoryBox(
              categoryName: 'after_isha'.tr,
              days: 21,
              hours: 12,
              checkbox: false,
              isSelected: false,
              comingSoon: false,
              showDate: false,
            ),onTap: (){
              nextScreen(context, SupplicationsDetails('isha'));
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
