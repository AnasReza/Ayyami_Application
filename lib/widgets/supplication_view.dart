import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class SupplicationView extends StatelessWidget {
  String heading, times, dua, description;
  bool darkMode;

  SupplicationView(this.darkMode, this.heading, this.dua, this.times, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
            border: Border.all(
              color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: const [
              BoxShadow(color: Color(0x1e1f3d73), offset: Offset(0, 12), blurRadius: 40, spreadRadius: 0)
            ],
          ),
          child: Column(
            children: [
              Text(
                heading,
                style: TextStyle(
                    color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.end,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 216, 220, 227).withOpacity(1.0),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '$times Times',
                  style: TextStyle(
                      color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      fontFamily: 'Al Qalam Quran Majeed Web'),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          dua,
          style: TextStyle(
              color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'Al Qalam Quran Majeed Web'),
          textAlign: TextAlign.end,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
