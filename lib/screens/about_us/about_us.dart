import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/widgets/side_bar_bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/images.dart';

class AboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutUsState();
  }
}

class AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: SvgPicture.asset(
          AppImages.logo,
          width: 249.6.w,
          height: 78.4.h,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(
                      AppImages.backIcon,
                      width: 49.w,
                      height: 34.h,
                    ),
                  ),
                  SizedBox(width: 110.w),
                  const Text(
                    'About Us',
                    style: TextStyle(
                      color: AppColors.headingColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'about_us'.tr,
                style: const TextStyle(color: AppColors.headingColor, fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'verified_by'.tr,
                    style: const TextStyle(color: AppColors.headingColor, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Image.asset(AppImages.deobandIcon,width: MediaQuery.of(context).size.width*0.5,),

                ],
              ),
              const SizedBox(height: 20,),
              SideBarBottomView('suggest_update'.tr, AppImages.suggestIcon)
            ],
          ),
        ),
      ),
    ));
  }
}
