import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/widgets/likoria_timer_box.dart';
import 'package:ayyami/widgets/post_natal_timer_box.dart';
import 'package:ayyami/widgets/pregnancy_timer_box.dart';
import 'package:ayyami/widgets/menses_timer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/images.dart';

class AllTrackers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllTrackersState();
  }
}

class AllTrackersState extends State<AllTrackers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset(
          AppImages.logo,
          width: 249.6.w,
          height: 78.4.h,
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 30),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              AppImages.backIcon,
              width: 49.w,
              height: 34.h,
            ),
          ),
        ),
        leadingWidth: 60,
      ),
      body: Container(width: double.infinity,

        padding: EdgeInsets.only(left: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text('pregnancy'.tr,style: TextStyle(color: AppColors.headingColor,fontSize: 25,fontWeight: FontWeight.w700),),
              const SizedBox(height: 10,),
              PregnancyTimerBox(mensis: (value){}),
              const SizedBox(
                height: 60,
              ),
              Text('likoria'.tr,style: TextStyle(color: AppColors.headingColor,fontSize: 25,fontWeight: FontWeight.w700),),
              const SizedBox(height: 10,),
              LikoriaTimerBox(mensis: (value){}),

              const SizedBox(
                height: 60,
              ),
              Text('menstrual_bleeding'.tr,style: TextStyle(color: AppColors.headingColor,fontSize: 25,fontWeight: FontWeight.w700),),
              const SizedBox(height: 10,),
              TimerBox(mensis: (value){}),

              const SizedBox(
                height: 60,
              ),
              Text('post-natal_bleeding'.tr,style: TextStyle(color: AppColors.headingColor,fontSize: 25,fontWeight: FontWeight.w700),),
              const SizedBox(height: 10,),
              PostNatalTimerBox(mensis: (value){}),
              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
