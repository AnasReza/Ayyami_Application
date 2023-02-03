import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';
import 'app_text.dart';

class QuestionAnswerView extends StatelessWidget {
  String question, answer;
  bool darkMode;

  QuestionAnswerView({super.key, required this.question, required this.answer,required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: answer != '',
      child: Column(children: [Row(
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: question, fontSize: 18.sp,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,),
              const SizedBox(
                height: 5,
              ),
              AppText(
                text: answer,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
              ),
            ],
          ),
        ],
      ),const SizedBox(height: 30,)],)
    );
  }
}
