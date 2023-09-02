import 'package:ayyami/constants/const.dart';
import 'package:ayyami/widgets/details_widget.dart';
import 'package:ayyami/widgets/total_duration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/dark_mode_colors.dart';
import '../../constants/images.dart';
import '../../providers/user_provider.dart';
import '../../translation/app_translation.dart';
import '../../widgets/app_text.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails(this.heading, this.data, {super.key});

  final String heading;
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      var darkMode = provider.getIsDarkMode;
      var text = AppTranslate().textLanguage[provider.getLanguage!];
      int days = data['days'];
      int hours = data['hours'];
      int minutes = data['minutes'];
      Timestamp startStamp = data.get('start_date');
      Timestamp endStamp = data.get('end_time');
      DateTime startDate = startStamp.toDate();
      DateTime endDate = endStamp.toDate();
      var dayFormat = DateFormat('EEEE');
      var monthFormat = DateFormat('MMMM');
      var startAMPM = DateFormat('a').format(startDate);
      var endAMPM = DateFormat('a').format(endDate);
      var starttime = DateFormat('hh:mm').format(startDate);
      var endtime = DateFormat('hh:mm').format(endDate);
      String startDayName = dayFormat.format(startDate);
      String startMonthName = monthFormat.format(startDate);
      String endDayName = dayFormat.format(endDate);
      String endMonthName = monthFormat.format(endDate);
      if (provider.getLanguage == 'ur') {
        startDayName = getUrduDayNames(startDayName)!;
        endDayName = getUrduDayNames(endDayName)!;
      }

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: darkMode
                ? AppDarkColors.backgroundGradient
                : AppColors.backgroundGradient,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 70.w,
              right: 70.w,
              top: 80.h,
            ),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          darkMode ? AppImages.logo_white : AppImages.logo,
                          width: 249.6.w,
                          height: 78.4.h,
                        ),
                      ),
                      SizedBox(height: 70.6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: SvgPicture.asset(
                              AppImages.backIcon,
                              width: 49.w,
                              height: 34.h,
                              color: darkMode
                                  ? AppDarkColors.headingColor
                                  : AppColors.headingColor,
                            ),
                          ),
                          AppText(
                            text: heading,
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w700,
                            color: darkMode
                                ? AppDarkColors.headingColor
                                : AppColors.headingColor,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              AppImages.shareIcon,
                              width: 33.w,
                              height: 33.h,
                              color: darkMode
                                  ? AppDarkColors.headingColor
                                  : AppColors.headingColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 41.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DetailsWidget(
                              backgroundColor: AppColors.startDateColor,
                              monthYear: '$startMonthName ${startDate.year}',
                              day: startDate.day.toString(),
                              dayName: startDayName,
                              lang: provider.getLanguage!,
                              heading: text!['start_date']!),
                          DetailsWidget(
                              backgroundColor: AppColors.endDateColor,
                              monthYear: '$endMonthName ${endDate.year}',
                              day: endDate.day.toString(),
                              lang: provider.getLanguage!,
                              dayName: endDayName,
                              heading: text['end_date']!),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DetailsWidget(
                              backgroundColor: AppColors.startTimeColor,
                              monthYear: startAMPM,
                              day: starttime,
                              dayName: '',
                              lang: provider.getLanguage!,
                              heading: text['start_time']!),
                          DetailsWidget(
                              backgroundColor: AppColors.endTimeColor,
                              monthYear: endAMPM,
                              day: endtime,
                              dayName: '',
                              lang: provider.getLanguage!,
                              heading: text['end_time']!),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TotalDuration(
                          text: text,
                          lang: provider.language,
                          days: days.toString(),
                          hours: hours.toString(),
                          minutes: minutes.toString())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
