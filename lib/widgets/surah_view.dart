import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';

class SurahView extends StatefulWidget {
  bool darkMode;
  String surah, heading;

  SurahView(this.darkMode, this.surah, this.heading, {super.key});

  @override
  State<StatefulWidget> createState() {
    return SurahViewState();
  }
}

class SurahViewState extends State<SurahView> {
  double _fontSize = 20;
  final double _baseFontSize = 20;
  double _fontScale = 1;
  double _baseFontScale = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.darkMode ? AppDarkColors.lightGreyBoxColor : AppColors.lightGreyBoxColor,
            border: Border.all(
              color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: const [
              BoxShadow(color: Color(0x1e1f3d73), offset: Offset(0, 12), blurRadius: 40, spreadRadius: 0)
            ],
          ),
          child: Column(
            children: [
              Text(
                widget.heading,
                style: TextStyle(
                    color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.surah,
          style: TextStyle(
              color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
              fontSize: _fontSize,
              fontWeight: FontWeight.w400,
              fontFamily: 'Al Qalam Quran Majeed Web'),
          textAlign: TextAlign.end,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
