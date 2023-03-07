import 'package:ayyami/constants/const.dart';
import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:ayyami/widgets/customerSwitch1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'constants/colors.dart';
import 'constants/dark_mode_colors.dart';
import 'constants/images.dart';

class CalenderPage extends StatefulWidget {
  CalenderPage({required this.darkMode, required this.dateRangeList, required this.hijriRangeList, Key? key})
      : super(key: key);

  bool darkMode;
  List<PickerDateRange> dateRangeList;
  List<HijriDateRange> hijriRangeList;

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  var today = HijriCalendar.now();
  var dateNow = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrayerProvider>(context);

    return Scaffold(
      body: Container(
        height: getHeight(context),
        decoration: BoxDecoration(
          gradient: widget.darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient,
        ),
        child: SafeArea(
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
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: SvgPicture.asset(
                              AppImages.backIcon,
                              width: 49.w,
                              height: 34.h,
                              color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                            ),
                          ),
                          SizedBox(width: 110.w),
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              widget.darkMode ? AppImages.logo_white : AppImages.logo,
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
                            color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                          ),
                          SizedBox(width: 30.6.h),
                          CustomSwitch1(
                            value: child.hijriCalender,
                            onChanged: ((value) {
                              provider.setHijriCalender(value);
                            }),
                            activeColor: AppColors.black,
                            darkMode: widget.darkMode,
                          ),
                          SizedBox(width: 30.6.h),
                          AppText(
                            text: "Hijri",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 70.6.h),
                      child.hijriCalender
                          ? SfHijriDateRangePicker(
                              selectionMode: DateRangePickerSelectionMode.multiRange,
                              headerStyle: DateRangePickerHeaderStyle(
                                textStyle: TextStyle(
                                    color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
                              ),
                              monthCellStyle: HijriDatePickerMonthCellStyle(
                                textStyle: TextStyle(
                                    color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
                              ),
                              yearCellStyle: HijriDatePickerYearCellStyle(
                                  textStyle: TextStyle(
                                      color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor)),
                              monthViewSettings: HijriDatePickerMonthViewSettings(
                                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                      textStyle: TextStyle(
                                          color:
                                              widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor))),
                              initialSelectedRanges: widget.hijriRangeList,
                              enablePastDates: true,
                              startRangeSelectionColor: Colors.red,
                              endRangeSelectionColor: Colors.green,
                              rangeSelectionColor: Colors.blue,
                            )
                          : SfDateRangePicker(
                              selectionMode: DateRangePickerSelectionMode.multiRange,
                              headerStyle: DateRangePickerHeaderStyle(
                                textStyle: TextStyle(
                                    color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
                              ),
                              monthCellStyle: DateRangePickerMonthCellStyle(
                                textStyle: TextStyle(
                                    color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
                              ),
                              yearCellStyle: DateRangePickerYearCellStyle(
                                  textStyle: TextStyle(
                                      color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor)),
                              monthViewSettings: DateRangePickerMonthViewSettings(
                                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                      textStyle: TextStyle(
                                          color:
                                              widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor))),
                              // initialSelectedRanges: [
                              //   PickerDateRange(DateTime.now(), DateTime.now().add(Duration(days: 7))),
                              //   PickerDateRange(DateTime.now().subtract(Duration(days: 30)), DateTime.now().subtract(Duration(days: 25))),
                              // ],
                              initialSelectedRanges: widget.dateRangeList,

                              enablePastDates: true,
                              startRangeSelectionColor: Colors.red,
                              endRangeSelectionColor: Colors.green,
                              rangeSelectionColor: Colors.blue,
                            )
                      // child.hijriCalender
                      //     ? Container(color:widget.darkMode?Colors.white:Colors.transparent,child: HijriMonthPicker(
                      //   lastDate: HijriCalendar()
                      //     ..hYear = 1445
                      //     ..hMonth = 9
                      //     ..hDay = 25,
                      //   firstDate: HijriCalendar()
                      //     ..hYear = 1438
                      //     ..hMonth = 12
                      //     ..hDay = 25,
                      //   onChanged: (HijriCalendar value) {},
                      //   selectedDate: today,
                      // ),)
                      //     : TableCalendar(
                      //         calendarBuilders: const CalendarBuilders(),
                      //         weekNumbersVisible: false,
                      //         focusedDay: DateTime.now(),
                      //         lastDay: DateTime(2050, 12, 2),
                      //         firstDay: DateTime(1965, 12, 2),
                      //         calendarStyle: CalendarStyle(
                      //             defaultTextStyle: TextStyle(
                      //                 color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor)),
                      //         headerStyle: HeaderStyle(
                      //             formatButtonDecoration: BoxDecoration(
                      //               color: Colors.brown,
                      //               borderRadius: BorderRadius.circular(22.0),
                      //             ),
                      //             titleTextStyle: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 16,
                      //                 fontFamily: fontFamily,
                      //                 color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
                      //             formatButtonTextStyle: TextStyle(color: Colors.white),
                      //             leftChevronIcon: RotatedBox(
                      //               quarterTurns: 2,
                      //               child: SvgPicture.asset(AppImages.forwardIcon,
                      //                   color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
                      //             ),
                      //             rightChevronIcon: SvgPicture.asset(AppImages.forwardIcon,
                      //                 color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
                      //             formatButtonShowsNext: false,
                      //             formatButtonVisible: false,
                      //             titleCentered: true),
                      //         daysOfWeekStyle: DaysOfWeekStyle(
                      //             weekdayStyle: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
                      //             weekendStyle: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor)),
                      //         startingDayOfWeek: StartingDayOfWeek.monday,
                      //         onDaySelected: (date, events) {
                      //           print(date.toUtc());
                      //         },
                      //         rangeStartDay: DateTime.now(),
                      //         rangeEndDay: DateTime(dateNow.year, dateNow.month, dateNow.day + 7),
                      //       )
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
