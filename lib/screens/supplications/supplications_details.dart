import 'package:ayyami/constants/const.dart';
import 'package:ayyami/widgets/supplication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/images.dart';

class SupplicationsDetails extends StatelessWidget {
  String prayerTime = '';

  SupplicationsDetails(this.prayerTime, {super.key});

  @override
  Widget build(BuildContext context) {
    var list = getDuaMap(prayerTime);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset(
          AppImages.logo,
          width: 249.6.w,
          height: 78.4.h,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: ListView.builder(
            itemCount: list?.length,
            itemBuilder: (listContext, index) {
              return SupplicationView(
                  list![index]['heading']!, list[index]['dua']!, list[index]['times']!, list[index]['description']!);
            }),
      ),
    );
  }
}
