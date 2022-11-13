import 'package:ayyami/models/medicine_model.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/widgets/add_medicine.dart';
import 'package:ayyami/widgets/customerSwitch1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import 'medicine_container.dart';

class ExpandedReminderContainer extends StatefulWidget {
  ExpandedReminderContainer({
    Key? key,
    required this.regulationExpanded,
  }) : super(key: key);

  bool regulationExpanded = true;
  bool isSwitched = false;

  @override
  State<ExpandedReminderContainer> createState() =>
      _ExpandedReminderContainerState();
}

class _ExpandedReminderContainerState extends State<ExpandedReminderContainer> {
  bool isMedicineReminder = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerProvider>(
      builder: (context,child,build) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: widget.regulationExpanded ? 124.h : 470.h,
            decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(width: 1.w, color: AppColors.headingColor),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x1e1f3d73),
                    offset: const Offset(0, 12),
                    blurRadius: 40.r,
                    spreadRadius: 0)
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Medicine Reminder",
                          style: TextStyle(
                            color: const Color(0xff1f3d73),
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Row(
                          children: [
                            CustomSwitch1(
                                value: widget.isSwitched,
                                onChanged: ((value) {
                                  setState(() {
                                    value = widget.isSwitched;
                                  });
                                }),
                                activeColor: AppColors.black)
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.regulationExpanded =
                                  !widget.regulationExpanded;
                            });
                          },
                          child: SvgPicture.asset(
                            widget.regulationExpanded
                                ? AppImages.downIcon
                                : AppImages.upIcon,
                            // width: 17.6.w,
                            // height: 8.8.h,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    widget.regulationExpanded
                        ? const SizedBox()
                        : Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(child.medicinesLsit.length, (index) =>
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                                        child: MedicineContainer(medicineTime: child.medicinesLsit[index].timing,medicinetitle: child.medicinesLsit[index].medicalTile,),
                                      ))
                                ),
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog(context: context, builder: (c){
                                    return AlertDialog(
                                      title: Text("Add Medicine"),
                                      content: SizedBox(
                                        height: 200,
                                        child: AddMedicine()
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 82.h,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffd9d9d9),
                                      borderRadius: BorderRadius.circular(8.r)),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppImages.add_icon,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
