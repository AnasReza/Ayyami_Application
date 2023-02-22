import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/gradient_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/images.dart';
import '../../translation/app_translation.dart';
import '../../widgets/app_text.dart';

class ChangeLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangeLocationState();
  }
}

class ChangeLocationState extends State<ChangeLocation> {
  String labelText = '';
  late GeoPoint currentPoint;

  @override
  Widget build(BuildContext context) {

   return Consumer<UserProvider>(builder: (c,provider,child){
     bool darkMode=provider.getIsDarkMode;
     var lang=provider.getLanguage;
     var text=AppTranslate().textLanguage[lang];

     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         backgroundColor: darkMode?AppDarkColors.white:Colors.white,
         title: SvgPicture.asset(
           darkMode?AppImages.logo_white:AppImages.logo,
           width: 249.6.w,
           height: 78.36.h,
         ),
         centerTitle: true,
         // actions: [
         //   InkWell(
         //     onTap: () {
         //       _key.currentState!.openDrawer();
         //       // Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTiming()));
         //     },
         //     child: SvgPicture.asset(
         //       AppImages.menuIcon,
         //       width: 44.w,
         //       height: 38.h,
         //     ),
         //   ),
         // ],
       ),
       body: Container(
         padding: EdgeInsets.only(left: 30,right: 30),
         decoration: BoxDecoration(gradient: darkMode?AppDarkColors.backgroundGradient:AppColors.backgroundGradient),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(
               width: double.infinity,
               child: Row(
                 children: [
                   SvgPicture.asset(AppImages.backIcon,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,),
                   Expanded(
                     child: Align(
                       alignment: Alignment.center,
                       child: AppText(
                         text: text!['change_location']!,
                         fontSize: 45.sp,
                         fontWeight: FontWeight.w700,
                         color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             const SizedBox(
               height: 30,
             ),
             AppText(
               text: text['your_location']!,
               fontSize: 36.sp,
               fontWeight: FontWeight.w700,
               color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,

             ),
             const SizedBox(
               height: 20,
             ),
             Row(
               children: [
                 SvgPicture.asset(AppImages.locationIcon,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,),
                 const SizedBox(
                   width: 20,
                 ),
                 Expanded(
                   child: TextField(
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       isDense: true,
                       label: AppText(text: labelText, fontSize: 18, fontWeight: FontWeight.w700,color:darkMode?AppDarkColors.headingColor:AppColors.headingColor,),
                     ),
                   ),
                 ),
               ],
             ),
             const Divider(color: AppColors.grey, thickness: 0.5, height: 15.0),
             const SizedBox(height: 20,),
             GestureDetector(child: Row(
               children: [
                 SvgPicture.asset(AppImages.locateIcon, width: 30, height: 30,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,),
                 const SizedBox(
                   width: 20,
                 ),
                 AppText(text: text['locate_me']!, fontSize: 18, fontWeight: FontWeight.w700,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,),
               ],
             ), onTap: () {
               _determinePosition().then((value) async {
                 print('${value.latitude}==Latitude     ${value.longitude}==longitude');
                 currentPoint=GeoPoint(value.latitude, value.longitude);
                 await placemarkFromCoordinates(value.latitude, value.longitude).then((value) {
                   print('${value.length}==length');
                   print('${value.first.name}==name');
                   print('${value.first.locality}==locality');
                   print('${value.first.country}==country');
                   setState(() {
                     labelText = '${value.first.locality}, ${value.first.country}';
                   });
                 });
               });
             },),
             const SizedBox(height: 30,),
             GradientButton(title: text['save']!, onPressedButon: () {
               if (currentPoint != null) {
                 var provider=Provider.of<UserProvider>(context,listen: false);
                 String? uid=provider.getUid;
                 UsersRecord().updateLocation(uid!, labelText, currentPoint).then((value){
                   provider.setLocation(labelText);
                   provider.setCurrentPoint(currentPoint);
                   Navigator.pop(context);
                 });
               }

             }),

           ],
         ),
       ),
     );
   });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Geolocator.openAppSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Geolocator.openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
