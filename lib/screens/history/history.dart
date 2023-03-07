import 'package:ayyami/constants/const.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/history/history_details.dart';
import 'package:ayyami/translation/app_translation.dart';
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
  List<String> items = [];
  String? selectedValue;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allTuhur = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allMenses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var userPro = context.read<UserProvider>();
    var uid = userPro.getUid;
    getMensesData(uid);
    getTuhurData(uid);
  }

  getMensesData(String uid) {
    MensesRecord().getAllMensesRecord(uid).listen((event) {
      allMenses.clear();
      print('${event.docs.length} menses length');
      setState(() {
        allMenses = event.docs;
      });
    });
  }

  getTuhurData(String uid) {
    TuhurRecord().getAllTuhurRecord(uid).listen((event) {
      allTuhur.clear();
      setState(() {
        allTuhur = event.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<UserProvider>(builder: (c, provider, child) {
      print('${allMenses.length} length from build method');
      var darkMode = provider.getIsDarkMode;
      var text = AppTranslate().textLanguage[provider.getLanguage!];
      items = [text!['6_month']!, text['1_year']!, text['2_year']!, text['5_year']!];
      return Scaffold(
          body: Container(
              decoration: BoxDecoration(
                gradient: darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient,
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
                              darkMode ? AppImages.logo_white : AppImages.logo,
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
                                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                              ),
                              AppText(
                                text: text!['full_history']!,
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w700,
                                color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                              ),
                              InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  AppImages.shareIcon,
                                  width: 33.w,
                                  height: 33.h,
                                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 41.h),
                          Directionality(textDirection: provider.getLanguage=='ur'?TextDirection.rtl:TextDirection.ltr, child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AppText(
                                text: text['see_history']!,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                                color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                              ),
                              CustomDropdownButton2(
                                hint: text['1_year']!,
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
                          ),),

                          SizedBox(height: 71.h),
                          Visibility(
                            visible: allTuhur.isNotEmpty && allMenses.isNotEmpty,
                            replacement: Text(
                              text['no_record']!,
                              style: TextStyle(
                                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            child: Expanded(
                                child: ListView.builder(
                                    itemCount: allMenses.length,
                                    itemBuilder: (c, index) {
                                      print('$index from menses list');
                                      return Column(
                                        children: [
                                          AppText(
                                            text: "5 September 2022",
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(height: 10.h),
                                          // GestureDetector(child: CategoryBox(
                                          //   categoryName: text['tuhur']!,
                                          //   days: allTuhur[index]['days'],
                                          //   hours: allTuhur[index]['hours'],
                                          //   checkbox: true,
                                          //   showDate: false,
                                          //   isSelected: false,
                                          //   comingSoon: false,
                                          //   darkMode: darkMode,
                                          // ),onTap: (){
                                          //   nextScreen(context, HistoryDetails(text['tuhur']!,allTuhur[index],text));
                                          // },),

                                          SizedBox(height: 41.h),
                                          GestureDetector(child: CategoryBox(
                                            categoryName: text['menses']!,
                                            days: allMenses[0]['days'],
                                            hours: allMenses[0]['hours'],
                                            checkbox: true,
                                            comingSoon: false,
                                            showDate: false,
                                            isSelected: false,
                                            darkMode: darkMode,
                                            text: text,
                                          ),onTap: (){
                                            print('${allMenses.length} length on click');
                                            nextScreen(context, HistoryDetails(text['menses']!,allMenses[0]));
                                          },),

                                          SizedBox(height: 41.h),
                                          Divider(
                                            color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                            thickness: 1,
                                          )
                                        ],
                                      );
                                    })),
                          )

                          // Expanded(
                          //   child: SingleChildScrollView(
                          //     child: Column(
                          //       children: [
                          //         AppText(
                          //           text: "5 September 2022",
                          //           fontSize: 20.sp,
                          //           fontWeight: FontWeight.w400,
                          //           color: AppColors.grey,
                          //         ),
                          //         SizedBox(height: 15.h),
                          //         CategoryBox(
                          //           categoryName: 'Tuhur',
                          //           days: 21,
                          //           hours: 12,
                          //           checkbox: true,
                          //           showDate: true,
                          //           isSelected: true,
                          //           comingSoon: false,
                          //           darkMode: darkMode,
                          //         ),
                          //         SizedBox(height: 41.h),
                          //         CategoryBox(
                          //           categoryName: 'Mensis',
                          //           days: 4,
                          //           hours: 8,
                          //           checkbox: true,
                          //           comingSoon: false,
                          //           showDate: true,
                          //           isSelected: true,
                          //           darkMode: darkMode,
                          //         ),
                          //         SizedBox(height: 41.h),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ]))));
    });
  }
}
