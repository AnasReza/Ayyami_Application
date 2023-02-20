import 'package:ayyami/constants/images.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:ayyami/widgets/customerSwitch1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';

class CategoryBoxWithSwitch extends StatefulWidget {
  CategoryBoxWithSwitch(
      {Key? key, required this.categoryName, required this.comingSoon, required this.onchange, required this.darkMode})
      : super(key: key);

  final String categoryName;
  bool comingSoon, darkMode;
  Function(bool) onchange;

  @override
  State<CategoryBoxWithSwitch> createState() => CategoryBoxWithSwitchState();
}

class CategoryBoxWithSwitchState extends State<CategoryBoxWithSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      width: double.infinity,
      height: 104.h,
      decoration: BoxDecoration(
        color: widget.darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
        border: Border.all(
          color: widget.darkMode ? AppColors.headingColor : AppColors.headingColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: const [BoxShadow(color: Color(0x1e1f3d73), offset: Offset(0, 12), blurRadius: 40, spreadRadius: 0)],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          36.w,
          19.h,
          54.w,
          21.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Wrap(
              spacing: 10,
              children: [
                AppText(
                  text: widget.categoryName,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                ),
                widget.comingSoon
                    ? Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(color: AppColors.lightGreen, borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'Coming soon',
                          style: TextStyle(fontSize: 5, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                      )
                    : Container(),
              ],
            )),
            SizedBox(width: 20.w),
            CustomSwitch1(
              value: widget.darkMode,
              onChanged: (value) {
                widget.onchange(value);
              },
              activeColor: AppColors.black,
              darkMode: widget.darkMode,
            )
          ],
        ),
      ),
    );
  }
}
