import 'package:ayyami/constants/const.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:ayyami/widgets/customerSwitch1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'constants/colors.dart';
import 'constants/images.dart';
class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  var today = HijriCalendar.now();
  var dateNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrayerProvider>(context);
    return Scaffold(
      body: Container(
        height: getHeight(context),
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
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
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppImages.logo,
                              width: 249.6.w,
                              height: 78.4.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 70.6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Gregorian",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(width: 30.6.h),
                          CustomSwitch1(
                            value: child.hijriCalender,
                            onChanged: ((value) {
                              provider.setHijriCalender(value);
                            }),
                            activeColor: AppColors.black,
                          ),
                          SizedBox(width: 30.6.h),
                          AppText(
                            text: "Hijri",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(height: 70.6.h),
                      child.hijriCalender ? HijriMonthPicker(
                        lastDate: HijriCalendar()
                          ..hYear = 1445
                          ..hMonth = 9
                          ..hDay = 25,
                        firstDate: HijriCalendar()
                          ..hYear = 1438
                          ..hMonth = 12
                          ..hDay = 25,
                        onChanged: (HijriCalendar value) {},
                        selectedDate: today,
                      ):
                      TableCalendar(
                        calendarBuilders: const CalendarBuilders(),
                        weekNumbersVisible: false,
                        focusedDay: DateTime.now(),
                        lastDay: DateTime(2050,12,2),
                        firstDay: DateTime(1965,12,2),
                        calendarStyle: const CalendarStyle(),
                        headerStyle: HeaderStyle(
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: fontFamily),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonShowsNext: false,
                          formatButtonVisible: false,
                          titleCentered: true
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: TextStyle(fontWeight: FontWeight.bold),weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        onDaySelected: (date, events) {
                          print(date.toUtc());
                        },
                        rangeStartDay: DateTime.now(),
                        rangeEndDay: DateTime(dateNow.year,dateNow.month,dateNow.day + 7),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
