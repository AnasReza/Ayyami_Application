import 'package:ayyami/calender_page.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/widgets/prayer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../widgets/app_text.dart';

class PrayerTiming extends StatefulWidget {
  const PrayerTiming({Key? key}) : super(key: key);

  @override
  State<PrayerTiming> createState() => _PrayerTimingState();
}

class _PrayerTimingState extends State<PrayerTiming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(
            left: 70.w,
            right: 70.w,
            top: 80.h,
          ),
          child: Consumer<PrayerProvider>(
            builder: (context, child,data) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CalenderPage()));
                    }, icon: Icon(Icons.date_range)),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: SvgPicture.asset(
                    //     AppImages.logo,
                    //     width: 249.6.w,
                    //     height: 78.4.h,
                    //   ),
                    // ),
                    SizedBox(height: 70.6.h),
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
                        AppText(
                          text: "Prayer Times",
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppText(
                      textAlign: TextAlign.center,
                      text: "${child.gorgeonTodayDateFormated}\n${child.hijriDateFormated}",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Fajar',
                      time: child.fajr,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Sunrise',
                      time: child.sunrise,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Dhuhr',
                      time: child.duhar,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Asar',
                      time: child.asar,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Maghrib',
                      time: child.maghrib,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Isha',
                      time: child.isha,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
