import 'package:ayyami/constants/images.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class CategoryBox extends StatefulWidget {
  CategoryBox({
    Key? key,
    required this.categoryName,
    required this.days,
    required this.hours,
    required this.checkbox,
    required this.isSelected,
    required this.showDate
  }) : super(key: key);

  final String categoryName;
  final int days, hours;
  bool checkbox, isSelected,showDate;

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
                margin: EdgeInsets.only(left: 30,right: 30),
                width: double.infinity,
                height: 104.h,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyBoxColor,
                  border: Border.all(
                    color: AppColors.headingColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x1e1f3d73),
                        offset: Offset(0, 12),
                        blurRadius: 40,
                        spreadRadius: 0)
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
                        child: AppText(
                          text: widget.categoryName,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      //SizedBox(width: 205.w),
                     widget.showDate?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                              text: widget.days.toString(),
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700),
                          AppText(
                              text: "Days",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ],
                      ):Container(),
                      SizedBox(width: 20.w),
                      widget.showDate?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                              text: widget.hours.toString(),
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700),
                          AppText(
                              text: "Hours",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ],
                      ):Container(),
                      SizedBox(width: 24.w),
                      SvgPicture.asset(
                        AppImages.forwardIcon,
                        width: 46.w,
                        height: 25.h,
                      ),
                      SvgPicture.asset(
                        AppImages.forwardIcon,
                        width: 46.w,
                        height: 25.h,
                      ),
                      SvgPicture.asset(
                        AppImages.forwardIcon,
                        width: 46.w,
                        height: 25.h,
                      ),
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
              ),
            ],
          )
        : Container(
      margin:EdgeInsets.only(left: 30,right: 30),
            width: double.infinity,
            height: 104.h,
            decoration: BoxDecoration(
              color: AppColors.lightGreyBoxColor,
              border: Border.all(
                color: AppColors.headingColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x1e1f3d73),
                    offset: Offset(0, 12),
                    blurRadius: 40,
                    spreadRadius: 0)
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
                    child: AppText(
                      text: widget.categoryName,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  widget.showDate?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                          text: widget.days.toString(),
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700),
                      AppText(
                          text: "Days",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                    ],
                  ):Container(),
                  SizedBox(width: 20.w),
                  widget.showDate?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                          text: widget.hours.toString(),
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700),
                      AppText(
                          text: "Hours",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                    ],
                  ):Container(),
                  SizedBox(width: 30.w),
                  SvgPicture.asset(
                    AppImages.forwardIcon,
                    width: 46.w,
                    height: 25.h,
                  ),
                  SvgPicture.asset(
                    AppImages.forwardIcon,
                    width: 46.w,
                    height: 25.h,
                  ),
                  SvgPicture.asset(
                    AppImages.forwardIcon,
                    width: 46.w,
                    height: 25.h,
                  ),
                ],
              ),
            ),
          );
  }
}
