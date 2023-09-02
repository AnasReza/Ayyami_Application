import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class DetailsWidget extends StatelessWidget {
  Color backgroundColor;
  String heading, dayName, day, monthYear,lang;

  DetailsWidget(
      {required this.backgroundColor,
      required this.monthYear,
      required this.day,
      required this.dayName,
      required this.heading,
        required this.lang,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.37,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lang=='ur'?dayName:heading,
                style: TextStyle(color: AppColors.headingColor, fontSize: 25.sp, fontWeight: FontWeight.w700,fontFamily: 'DMSans'),
              ),
              Text(
                lang=='ur'?heading:dayName,
                style:TextStyle(color: AppColors.headingColor, fontSize: 25.sp, fontWeight: FontWeight.w700,fontFamily: 'DMSans'),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            day,
            style:  TextStyle(color: AppColors.headingColor, fontSize:40.sp, fontWeight: FontWeight.w700,fontFamily: 'DMSans'),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            monthYear,
            style: TextStyle(color: AppColors.headingColor, fontSize: 25.sp, fontWeight: FontWeight.w700,fontFamily: 'DMSans'),
          )
        ],
      ),
    );
  }
}
