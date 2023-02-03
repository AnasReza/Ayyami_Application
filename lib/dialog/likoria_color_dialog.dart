import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/images.dart';

class LikoriaColorDialog extends StatefulWidget {
  bool darkMode;
  LikoriaColorDialog({required this.darkMode});

  @override
  State<StatefulWidget> createState() {
    return LikoriaColorDialogState();
  }
}

class LikoriaColorDialogState extends State<LikoriaColorDialog> {
  List<String> likoriaNames = ['Yellow', 'White', 'Camel\nbrown', 'Green', 'Mud'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
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
                      BoxDecoration(gradient: widget.darkMode?AppDarkColors.backgroundGradient:AppColors.backgroundGradient, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text(
                        'likoria_color'.tr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: likoriaNames.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 50,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: AppColors.likoriaMap[e],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color:  widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor, width: 1)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  e,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color:  widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,

                                )
                              ],
                            );
                          }).toList(),
                        ),
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
                            'start_timer'.tr,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Image.asset(
                AppImages.colorIcon,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}