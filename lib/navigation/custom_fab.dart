
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/images.dart';

class FAB extends StatelessWidget {
  final Function(int tappingIndex) tappingIndex;
  const FAB({
    Key? key,
    required this.tappingIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return  Container(
    //   width: 140.w,
    //   height: 140.h,
    //   decoration: const BoxDecoration(
    //     shape: BoxShape.circle,
    //     //gradient: AppColors.bgPinkishGradient,
    //     // image: DecorationImage(
    //     //   image: AssetImage(AppImages.fabBtnGradientColor),
    //     //   fit: BoxFit.cover,
    //     // ),
    //     boxShadow: [
    //       BoxShadow(
    //           color: Color(0x1e000000),
    //           offset: Offset(0, 12),
    //           blurRadius: 40,
    //           spreadRadius: 0)
    //     ],
    //   ),
    //   child: FittedBox(
    //     child: FloatingActionButton(
    //       onPressed: () {},
    //       elevation: 0,
    //       backgroundColor: AppColors.pink,
    //       child: Container(
    //         width: 140.w,
    //         height: 140.h,
    //         decoration: const BoxDecoration(
    //           shape: BoxShape.circle,
    //           gradient: LinearGradient(
    //             colors: [Color(0xffffbbe6), Color(0xffc43cf3)],
    //             stops: [0, 1],
    //             begin: Alignment(-1.5, -1.00),
    //             end: Alignment(0.09, 1.00),
    //             // angle: 175,
    //             // scale: undefined,
    //           ),
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Color(0x1e000000),
    //                 offset: Offset(0, 12),
    //                 blurRadius: 40,
    //                 spreadRadius: 0)
    //           ],
    //         )
    //         // image: DecorationImage(
    //         //   image: AssetImage(AppImages.fabBtnGradientColor),
    //         //   fit: BoxFit.cover,
    //         // ),
    //         ,
    //         child: Column(
    //           children: [
    //             Expanded(
    //                 child: SvgPicture.asset(
    //               AppImages.homeBtn,
    //               height: 30.h,
    //               width: 30.w,
    //             )),
    //             Expanded(
    //               child: AppText(
    //                 text: "Home",
    //                 color: AppColors.white,
    //                 fontSize: 24.sp,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // ),
    return InkWell(
      onTap: () {
        tappingIndex(2);
      },
      child: SvgPicture.asset(
        AppImages.fabBtn,
        width: 180.w,
        height: 180.h,
      ),
    );
  }
}
