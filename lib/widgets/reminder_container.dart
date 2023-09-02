import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';
import 'customerSwitch1.dart';

class ReminderSwitchContainerWidget extends StatefulWidget {
  bool isSwitched = false;
  String title;
  bool darkMode;
  Function(bool) returnvalue;
  ReminderSwitchContainerWidget({
    required this.isSwitched,
    required this.title,
    required this.darkMode,
    required this.returnvalue,
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderSwitchContainerWidget> createState() => _ReminderSwitchContainerWidgetState();
}

class _ReminderSwitchContainerWidgetState extends State<ReminderSwitchContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 558.w,
      height: 101.h,
      decoration: BoxDecoration(
        color: widget.darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
              color: const Color(0x1e1f3d73),
              offset: const Offset(0, 12),
              blurRadius: 40.r,
              spreadRadius: 0)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          CustomSwitch1(
            value: widget.isSwitched,
            onChanged: ((value) {
              print('$value value cycle ');
              widget.returnvalue(value);
            }),
            activeColor: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
            darkMode: widget.darkMode,
          )
        ],
      ),
    );
  }
}
