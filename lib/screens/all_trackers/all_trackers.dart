import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/providers/pregnancy_timer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/tracker/post-natal_tracker.dart';
import 'package:ayyami/tracker/pregnancy_tracker.dart';
import 'package:ayyami/widgets/likoria_timer_box.dart';
import 'package:ayyami/widgets/post_natal_timer_box.dart';
import 'package:ayyami/widgets/pregnancy_timer_box.dart';
import 'package:ayyami/widgets/menses_timer_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/images.dart';

class AllTrackers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllTrackersState();
  }
}

class AllTrackersState extends State<AllTrackers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPregnancyDetails();
    getPostNatalDetails();
  }

  getPregnancyDetails() {
    var userProvider = context.read<UserProvider>();
    var pregProvider = context.read<PregnancyProvider>();
    FirebaseFirestore.instance
        .collection('pregnancy')
        .where('uid', isEqualTo: userProvider.getUid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
          var docList=event.docs;
          Timestamp startTime;
          for(var doc in docList){
            startTime=doc.get('start_date');
            try{
              Timestamp endTime = doc.get('end_time');

            }catch(e){
              pregProvider.setTimerStart(true);
              pregProvider.setStartTime(startTime);
              var diff=DateTime.now().difference(startTime.toDate());
              PregnancyTracker().startPregnancyAgain(pregProvider, diff.inMilliseconds);
            }
          }
    });
  }
  getPostNatalDetails(){
    var userProvider = context.read<UserProvider>();
    var postNatalProvider = context.read<PostNatalProvider>();
    FirebaseFirestore.instance
        .collection('post-natal')
        .where('uid', isEqualTo: userProvider.getUid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
      var docList=event.docs;
      Timestamp startTime;
      for(var doc in docList){
        startTime=doc.get('start_date');
        try{
          Timestamp endTime = doc.get('end_time');

        }catch(e){
          postNatalProvider.setTimerStart(true);
          postNatalProvider.setStartTime(startTime);
          var diff=DateTime.now().difference(startTime.toDate());
          PostNatalTracker().startPostNatalAgain(postNatalProvider, diff.inMilliseconds);
        }
      }
    });
  }
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
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'pregnancy'.tr,
                style: TextStyle(color: AppColors.headingColor, fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              PregnancyTimerBox(mensis: (value) {}),
              const SizedBox(
                height: 60,
              ),
              Text(
                'likoria'.tr,
                style: TextStyle(color: AppColors.headingColor, fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              LikoriaTimerBox(mensis: (value) {}),
              const SizedBox(
                height: 60,
              ),
              Text(
                'menstrual_bleeding'.tr,
                style: TextStyle(color: AppColors.headingColor, fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              TimerBox(mensis: (value, message) {}, islamicMonth: ''),
              const SizedBox(
                height: 60,
              ),
              Text(
                'post-natal_bleeding'.tr,
                style: TextStyle(color: AppColors.headingColor, fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              PostNatalTimerBox(mensis: (value) {}),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
