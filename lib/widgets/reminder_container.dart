import 'package:ayyami/widgets/customerSwitch1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class ReminderSwitchContainerWidget extends StatefulWidget {
  bool isSwitched = false;
  String title;
  bool darkMode;
  ReminderSwitchContainerWidget({
    required this.isSwitched,
    required this.title,
    required this.darkMode,
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderSwitchContainerWidget> createState() =>
      _ReminderSwitchContainerWidgetState();
}

class _ReminderSwitchContainerWidgetState
    extends State<ReminderSwitchContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 558.w,
      height: 101.h,
      decoration: BoxDecoration(
        color: const Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.headingColor,
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
              color: const Color(0xff1f3d73),
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          CustomSwitch1(
            value: widget.isSwitched,
            onChanged: ((value) {
              setState(() {
                value = widget.isSwitched;
              });
            }),
            activeColor: AppColors.black,
            darkMode: widget.darkMode,
          )
        ],
      ),
    );
  }
}
