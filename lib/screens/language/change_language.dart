import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../constants/const.dart';
import '../../constants/images.dart';

class changeLanguage extends StatefulWidget {
  const changeLanguage({super.key});

  @override
  State<changeLanguage> createState() => _changeLanguageState();
}

class _changeLanguageState extends State<changeLanguage> {
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
                child: Column(children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(
                      AppImages.backIcon,
                      width: 49.w,
                      height: 34.h,
                    ),
                  ),
                  SizedBox(width: 110.w),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppImages.logo,
                      width: 249.6.w,
                      height: 78.4.h,
                    ),
                  ),
                ],
              ),
             
                    const SizedBox(width: 15),
                   
              
              
              const SizedBox(height: 35),
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
                          "Add Medicine".toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                  ))
            ])),
          ),
        ),
      ),
    );
  }
  
}