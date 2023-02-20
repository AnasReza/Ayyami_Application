import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/providers/likoria_timer_provider.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/pregnancy_timer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/tracker/likoria_tracker.dart';
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
import '../../dialog/likoria_color_dialog.dart';
import '../../translation/app_translation.dart';

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
    getLikoriaDetails();
  }
  getLikoriaDetails(){
    var userProvider = context.read<UserProvider>();
    var likoriaProvider = context.read<LikoriaTimerProvider>();
    FirebaseFirestore.instance
        .collection('likoria')
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
          likoriaProvider.setTimerStart(true);
          likoriaProvider.setStartTime(startTime);
          var diff=DateTime.now().difference(startTime.toDate());
          LikoriaTracker().startLikoriaTimerAgain(likoriaProvider, diff.inMilliseconds);
        }
      }
    });
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
          postNatalProvider.setPostNatalID(doc.id);
          break;
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
    return Consumer<UserProvider>(builder: (c,provider,child){
      var prayerProvider=Provider.of<PrayerProvider>(context,listen: false);
      var darkMode=provider.getIsDarkMode;
      var lang=provider.getLanguage;
      var text=AppTranslate().textLanguage[lang];
      return Scaffold(
        appBar: AppBar(
          backgroundColor: darkMode?AppDarkColors.white:AppColors.white,
          elevation: 0,
          title: SvgPicture.asset(
            darkMode?AppImages.logo_white:AppImages.logo,
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
                color: darkMode?Colors.white:AppColors.headingColor,
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
                  text!['pregnancy']!,
                  style: TextStyle(color: darkMode?AppDarkColors.headingColor:AppColors.headingColor, fontSize: 25, fontWeight: FontWeight.w700,),
                ),
                const SizedBox(
                  height: 10,
                ),
                PregnancyTimerBox(),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  text!['likoria']!,
                  style: TextStyle(color: darkMode?AppDarkColors.headingColor:AppColors.headingColor, fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                LikoriaTimerBox(showDialog: (show){
                  if(show){
                    /// SHOW COLO DIALOG
                    showDialog(context: context, builder: (dialogContext){return LikoriaColorDialog(darkMode:darkMode);});
                  }
                }),
                const SizedBox(
                  height: 60,
                ),
                Text(
                 text!['menstrual_bleeding']!,
                  style: TextStyle(color: darkMode?AppDarkColors.headingColor:AppColors.headingColor, fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                TimerBox(mensis: (value, message) {}, islamicMonth: prayerProvider.hijriDateFormated),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  text!['post-natal_bleeding']!,
                  style: TextStyle(color: darkMode?AppDarkColors.headingColor:AppColors.headingColor, fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                PostNatalTimerBox(),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      );
    },);
  }
}
