import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../constants/const.dart';
import '../../constants/images.dart';
import '../../widgets/app_text.dart';

class changeLanguage extends StatefulWidget {
  const changeLanguage({super.key});

  @override
  State<changeLanguage> createState() => _changeLanguageState();
}

class _changeLanguageState extends State<changeLanguage> {
  bool englishSelected = true;
  bool urduSelected = false;
  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 110.w),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppImages.logo,
                    width: 249.6.w,
                    height: 78.4.h,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset(
                        AppImages.backIcon,
                        width: 49.w,
                        height: 34.h,
                      ),
                    ),
                    SizedBox(width: 30),
                    const AppText(
                      text: 'Change language',
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.w700,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: AppText(
                            text: 'English',
                            fontFamily: 'DMSans',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 180),
                        InkWell(
                          onTap: () {
                            setState(() {
                              englishSelected = !englishSelected;
                            });
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: englishSelected
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColors.headingColor,
                                      width: 1.5.w,
                                      strokeAlign: StrokeAlign.inside,
                                    ),
                                    gradient: AppColors.bgPinkishGradient,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0x1e1f3d73),
                                          offset: Offset(0, 12),
                                          blurRadius: 40,
                                          spreadRadius: 0)
                                    ],
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColors.headingColor,
                                      width: 1.5.w,
                                      strokeAlign: StrokeAlign.inside,
                                    ),
                                    color: AppColors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0x1e1f3d73),
                                          offset: Offset(0, 12),
                                          blurRadius: 40,
                                          spreadRadius: 0)
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: AppText(
                            text: 'اردو',
                            fontFamily: 'DMSans',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 210),
                        InkWell(
                          onTap: () {
                            setState(() {
                              urduSelected = !urduSelected;
                            });
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: urduSelected
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColors.headingColor,
                                      width: 1.5.w,
                                      strokeAlign: StrokeAlign.inside,
                                    ),
                                    gradient: AppColors.bgPinkishGradient,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0x1e1f3d73),
                                          offset: Offset(0, 12),
                                          blurRadius: 40,
                                          spreadRadius: 0)
                                    ],
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColors.headingColor,
                                      width: 1.5.w,
                                      strokeAlign: StrokeAlign.inside,
                                    ),
                                    color: AppColors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0x1e1f3d73),
                                          offset: Offset(0, 12),
                                          blurRadius: 40,
                                          spreadRadius: 0)
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 60),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.purpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(0.0)),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xffFFBBE6), Color(0xffC43CF3)],
                            begin: Alignment.centerLeft,
                            end: Alignment.center),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 360,
                            minHeight: 50,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Save".toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'DMSans',
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                    ))
              ],
            ),
          ),
        )),
      ),
    );
  }
  
}