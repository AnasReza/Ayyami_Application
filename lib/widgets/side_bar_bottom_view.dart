import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class SideBarBottomView extends StatelessWidget {
  String text, image;

  SideBarBottomView(this.text, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightGreyBoxColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.headingColor,
          width: 1.w,
        ),
      ),
      child: Wrap(spacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            width: 50.w,
            height: 50.h,
          ),
          Text(
            text,
            style: const TextStyle(color: AppColors.headingColor, fontWeight: FontWeight.w400, fontSize: 18),
          )
        ],
      ),
    );
  }
}
