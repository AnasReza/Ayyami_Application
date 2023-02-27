import 'package:flutter/material.dart';

import '../constants/colors.dart';

class DetailsWidget extends StatelessWidget {
  Color backgroundColor;
  String heading, dayName, day, monthYear;

  DetailsWidget(
      {required this.backgroundColor,
      required this.monthYear,
      required this.day,
      required this.dayName,
      required this.heading,
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
                heading,
                style: const TextStyle(color: AppColors.headingColor, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              Text(
                dayName,
                style: const TextStyle(color: AppColors.headingColor, fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            day,
            style: const TextStyle(color: AppColors.headingColor, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            monthYear,
            style: const TextStyle(color: AppColors.headingColor, fontSize: 14, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
