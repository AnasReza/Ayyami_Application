import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RateDialog extends StatelessWidget {
  bool darkMode;
  RateDialog({required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(

        height: 300,
        margin: EdgeInsets.only(left: 30, right: 30),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              IntrinsicHeight(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.only(top: 70),
                  decoration:
                      BoxDecoration(gradient: darkMode?AppDarkColors.backgroundGradient:AppColors.backgroundGradient, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text(
                        'like_using'.tr,
                        style:
                             TextStyle(color: darkMode?AppDarkColors.headingColor:AppColors.headingColor, fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'recommend_rating'.tr,
                        style:
                            TextStyle(color: darkMode?AppDarkColors.headingColor:AppColors.headingColor, fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: AppColors.bgPinkishGradient,
                              borderRadius:
                                  BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                          child: Text(
                            'rate_us'.tr,
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Image.asset(
                AppImages.rateIcon,
                width: 100,
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
