import 'package:adhan/adhan.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/prayer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_text.dart';

class PrayerTiming extends StatefulWidget {
  const PrayerTiming({Key? key}) : super(key: key);

  @override
  State<PrayerTiming> createState() => _PrayerTimingState();
}

class _PrayerTimingState extends State<PrayerTiming> {
  String fajr='',sunrise='',zuhar='',asr='',maghrib='',isha='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrayerTiming();
  }
  void getPrayerTiming() {
    var provider= context.read<UserProvider>();
    var currentPoints= provider.getCurrentPoint;
    final coordinates=Coordinates(currentPoints.latitude, currentPoints.longitude);
    final params=CalculationMethod.karachi.getParameters();
    params.madhab=Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(coordinates, params);
    print("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
    setState((){
      fajr=DateFormat.jm().format(prayerTimes.fajr);
      sunrise=DateFormat.jm().format(prayerTimes.sunrise);
      zuhar=DateFormat.jm().format(prayerTimes.dhuhr);
      asr=DateFormat.jm().format(prayerTimes.asr);
      maghrib=DateFormat.jm().format(prayerTimes.maghrib);
      isha=DateFormat.jm().format(prayerTimes.isha);
    });

    print(DateFormat.jm().format(prayerTimes.fajr));
    print(DateFormat.jm().format(prayerTimes.sunrise));
    print(DateFormat.jm().format(prayerTimes.dhuhr));
    print(DateFormat.jm().format(prayerTimes.asr));
    print(DateFormat.jm().format(prayerTimes.maghrib));
    print(DateFormat.jm().format(prayerTimes.isha));

  }
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
            builder: (context, child, data) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // IconButton(onPressed: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => CalenderPage()));
                    // }, icon: Icon(Icons.date_range)),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: SvgPicture.asset(
                    //     AppImages.logo,
                    //     width: 249.6.w,
                    //     height: 78.4.h,
                    //   ),
                    // ),
                    SizedBox(height: 70.6.h),
                    AppText(
                      text: "Prayer Times",
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w700,
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
                      time: fajr,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Sunrise',
                      time: sunrise,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Dhuhr',
                      time: zuhar,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Asar',
                      time: asr,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Maghrib',
                      time: maghrib,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    PrayerWidget(
                      name: 'Isha',
                      time: isha,
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
