import 'package:ayyami/constants/images.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';

class CategoryBox extends StatefulWidget {
  CategoryBox({
    Key? key,
    required this.categoryName,
    required this.days,
    required this.hours,
    required this.checkbox,
    required this.isSelected,
    required this.showDate,
    required this.comingSoon,
    required this.darkMode,
    required this.text,
    this.textDirection
  }) : super(key: key);

  final String categoryName;
  final int days, hours;
  bool checkbox, isSelected, showDate, comingSoon, darkMode;
  TextDirection? textDirection;
  Map<String,String> text;

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return widget.checkbox
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                width: double.infinity,
                height: 110.h,
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
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    36.w,
                    19.h,
                    54.w,
                    21.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Wrap(
                        children: [
                          AppText(
                            text: widget.categoryName,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                          ),
                          widget.comingSoon
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.lightGreen, borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    widget.text['coming_soon']!,
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                                  ),
                                )
                              : Container(),
                        ],
                      )),
                      //SizedBox(width: 205.w),
                      widget.showDate
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: widget.days.toString(),
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                                AppText(
                                  text: widget.text['days']!,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(width: 20.w),
                      widget.showDate
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: widget.hours.toString(),
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                                AppText(
                                  text: widget.text['hours']!,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(width: 24.w),
                      RotatedBox(quarterTurns: widget.textDirection==TextDirection.rtl?1:0,child: SvgPicture.asset(
                        AppImages.forwardIcon,
                        width: 46.w,
                        height: 25.h,
                        color: widget.darkMode ? Colors.white : Colors.black,
                      ),),


                      // SvgPicture.asset(
                      //   widget.textDirection==TextDirection.rtl?AppImages.backwardIcon:AppImages.forwardIcon,
                      //   width: 46.w,
                      //   height: 25.h,
                      //   color: widget.darkMode ? Colors.white : Colors.black,
                      // ),
                      // SvgPicture.asset(
                      //   widget.textDirection==TextDirection.rtl?AppImages.backwardIcon:AppImages.forwardIcon,
                      //   width: 46.w,
                      //   height: 25.h,
                      //   color: widget.darkMode ? Colors.white : Colors.black,
                      // ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 25.h,
                left: -25.w,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.isSelected = !widget.isSelected;
                    });
                  },
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: widget.isSelected
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.headingColor,
                              width: 1.5.w,
                              // strokeAlign: StrokeAlign.inside,
                            ),
                            gradient: AppColors.bgPinkishGradient,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0x1e1f3d73), offset: Offset(0, 12), blurRadius: 40, spreadRadius: 0)
                            ],
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.headingColor,
                              width: 1.5.w,
                              // strokeAlign: StrokeAlign.inside,
                            ),
                            color: AppColors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0x1e1f3d73), offset: Offset(0, 12), blurRadius: 40, spreadRadius: 0)
                            ],
                          ),
                  ),
                ),
              ),
            ],
          )
        : Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            width: double.infinity,
            height: 110.h,
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                36.w,
                19.h,
                54.w,
                21.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Wrap(
                    spacing: 10,
                    children: [
                      AppText(
                        text: widget.categoryName,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                      ),
                      widget.comingSoon
                          ? Container(
                              padding: EdgeInsets.all(3),
                              decoration:
                                  BoxDecoration(color: AppColors.lightGreen, borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                widget.text['coming_soon']!,
                                style: TextStyle(fontSize: 5, fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                            )
                          : Container(),
                    ],
                  )),
                  widget.showDate
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: widget.days.toString(),
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                            ),
                            AppText(
                              text: widget.text['days']!,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(width: 20.w),
                  widget.showDate
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: widget.hours.toString(),
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                            ),
                            AppText(
                              text: widget.text['hours']!,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(width: 30.w),
                  RotatedBox(quarterTurns: widget.textDirection==TextDirection.rtl?2:0,child: SvgPicture.asset(
                    AppImages.forwardIcon,
                    width: 46.w,
                    height: 25.h,
                    color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                  ),),

                  RotatedBox(quarterTurns: widget.textDirection==TextDirection.rtl?2:0,child: SvgPicture.asset(
                    AppImages.forwardIcon,
                    width: 46.w,
                    height: 25.h,
                    color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                  ),),
                  RotatedBox(quarterTurns: widget.textDirection==TextDirection.rtl?2:0,child: SvgPicture.asset(
                    AppImages.forwardIcon,
                    width: 46.w,
                    height: 25.h,
                    color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                  ),),
                ],
              ),
            ),
          );
  }
}
