import 'package:ayyami/widgets/category_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Supplications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SupplicationsState();
  }
}

class SupplicationsState extends State<Supplications> {
  @override
  Widget build(BuildContext context) {

    return Center(child:SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CategoryBox(
            categoryName: 'after_fajar'.tr,
            days: 21,
            hours: 12,
            checkbox: false,
            isSelected: false,
            showDate: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CategoryBox(
            categoryName: 'after_duhur'.tr,
            days: 21,
            hours: 12,
            checkbox: false,
            isSelected: false,
            showDate: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CategoryBox(
            categoryName: 'after_asar'.tr,
            days: 21,
            hours: 12,
            checkbox: false,
            isSelected: false,
            showDate: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CategoryBox(
            categoryName: 'after_maghrib'.tr,
            days: 21,
            hours: 12,
            checkbox: false,
            isSelected: false,
            showDate: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CategoryBox(
            categoryName: 'after_isha'.tr,
            days: 21,
            hours: 12,
            checkbox: false,
            isSelected: false,
            showDate: false,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),) ;
  }
}
