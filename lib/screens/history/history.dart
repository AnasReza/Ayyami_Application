import 'package:ayyami/constants/images.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../firebase_calls/tuhur_record.dart';
import '../../widgets/category_box.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<String> items = ['1 Week', '1 Month', '3 Months', '1 Year'];
  String? selectedValue;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allTuhur=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userPro=context.read<UserProvider>();
    TuhurRecord().getLastTuhur(userPro, (listTuhur) {
      print('${listTuhur.length} tuhur list');
      setState(() {
        allTuhur=listTuhur;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c,provider,child){
      var darkMode=provider.getIsDarkMode;
      return Scaffold(
          body: Container(
              decoration: BoxDecoration(
                gradient: AppColors.backgroundGradient,
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 70.w,
                    right: 70.w,
                    top: 80.h,
                  ),
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppImages.logo,
                              width: 249.6.w,
                              height: 78.4.h,
                            ),
                          ),
                          SizedBox(height: 70.6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: SvgPicture.asset(
                                  AppImages.backIcon,
                                  width: 49.w,
                                  height: 34.h,
                                ),
                              ),
                              AppText(
                                text: "Full History",
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  AppImages.shareIcon,
                                  width: 33.w,
                                  height: 33.h,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 41.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AppText(
                                text: "See history of",
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              CustomDropdownButton2(
                                hint: '1 Year',
                                icon: SvgPicture.asset(
                                  AppImages.downIcon,
                                  width: 20.w,
                                  height: 10.h,
                                  color: AppColors.grey,
                                ),
                                buttonDecoration: BoxDecoration(
                                  color: AppColors.lightGreyBoxColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0x1e1f3d73),
                                        offset: Offset(0, 12),
                                        blurRadius: 40,
                                        spreadRadius: 0)
                                  ],
                                ),
                                dropdownItems: items,
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 71.h),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  AppText(
                                    text: "5 September 2022",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey,
                                  ),
                                  SizedBox(height: 15.h),
                                  CategoryBox(
                                    categoryName: 'Tuhur',
                                    days: 21,
                                    hours: 12,
                                    checkbox: true,
                                    showDate: true,
                                    isSelected: true,
                                    comingSoon: false,
                                    darkMode:darkMode,
                                  ),
                                  SizedBox(height: 41.h),
                                  CategoryBox(
                                    categoryName: 'Mensis',
                                    days: 4,
                                    hours: 8,
                                    checkbox: true,
                                    comingSoon: false,
                                    showDate: true,
                                    isSelected: true,
                                    darkMode:darkMode,
                                  ),
                                  SizedBox(height: 41.h),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]))));
    });
  }
}
