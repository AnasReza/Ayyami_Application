import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';

class SideBarBox extends StatelessWidget {
  String text, image;
  bool showComingSoon,darkMode;

  SideBarBox(this.text, this.image, this.showComingSoon,this.darkMode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: darkMode?AppDarkColors.lightGreyBoxColor:AppColors.lightGreyBoxColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
          width: 1.w,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:70,child:  Stack(alignment: Alignment.center,
              children: [
                Align(alignment:Alignment.topRight,child: Visibility(
                  visible: showComingSoon,
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.lightGreen, borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(3),
                    child: const Text(
                      'Coming soon',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                ),),
                SvgPicture.asset(
                  image,
                  width: 50.w,
                  height: 50.h,
                  color:darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                ),
              ],
            ),),

            SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: TextStyle(color: darkMode?AppDarkColors.headingColor:AppColors.headingColor, fontWeight: FontWeight.w400, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
