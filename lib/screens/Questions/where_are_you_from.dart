import 'package:ayyami/constants/colors.dart';
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
import '../../firebase_calls/questions_record.dart';
import '../../widgets/app_text.dart';
import '../main_screen.dart';

class LocationQuestion extends StatefulWidget {
  String uid;

  LocationQuestion({super.key, required this.uid});

  @override
  State<StatefulWidget> createState() {
    return LocationQuestionState();
  }
}

class LocationQuestionState extends State<LocationQuestion> {
  String labelText = '';
  late GeoPoint currentPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          AppImages.logo,
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
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: AppText(
                        text: "where_are_you_from".tr,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.w700,
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
              text: "your_location".tr,
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SvgPicture.asset(AppImages.locationIcon),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      label: AppText(text: labelText, fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: AppColors.grey, thickness: 0.5, height: 15.0),
            const SizedBox(height: 20,),
            GestureDetector(child: Row(
              children: [
                SvgPicture.asset(AppImages.locateIcon, width: 30, height: 30,),
                const SizedBox(
                  width: 20,
                ),
                const AppText(text: 'Locate Me', fontSize: 18, fontWeight: FontWeight.w700,),
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
            GradientButton(title: 'save'.tr, onPressedButon: () {

              if (currentPoint != null) {
                var provider=Provider.of<UserProvider>(context,listen: false);
                QuestionRecord().uploadLocation(widget.uid,labelText,currentPoint).then((value){
                  provider.setCurrentPoint(currentPoint);
                  provider.setLocation(labelText);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MainScreen()));

                });

              }

            }),

          ],
        ),
      ),
    );
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
