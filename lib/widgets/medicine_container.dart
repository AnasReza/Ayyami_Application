import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/widgets/edit_medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants/images.dart';
import '../firebase_calls/user_record.dart';
import '../providers/medicine_provider.dart';
import '../providers/user_provider.dart';

class MedicineContainer extends StatelessWidget {
  final String medicinetitle;
  List<Map<String, dynamic>> medicineTime;
  Map<String, dynamic> medicineMap;
  String medId;
  String lang;
  bool darkMode;
  Map<String, String> text;
  int index;
  Function() returnFunction;

  MedicineContainer(
      {Key? key,
      required this.medicineTime,
      required this.medicinetitle,
      required this.medicineMap,
      required this.darkMode,
      required this.text,
      required this.lang,
      required this.medId,
      required this.index,
      required this.returnFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String medcinieTimeString = '';
    for (var timeName in medicineTime) {
      medcinieTimeString = '$medcinieTimeString\n${timeName['timeName']}';
    }
    return Container(
      padding: const EdgeInsets.all(8),
      width: 180.w,
      height: 240.h,
      decoration: BoxDecoration(
        color: darkMode ? AppDarkColors.greyBoxColor : AppColors.greyBoxColor,
        borderRadius: BorderRadius.circular(21.r),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: SvgPicture.asset(
                    AppImages.edit_icon,
                    height: 32.h,
                    width: 32.w,
                    color: darkMode
                        ? AppDarkColors.headingColor
                        : AppColors.headingColor,
                  ),
                  onTap: () {
                    print('$medId mediD on Click');
                    showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: SizedBox(
                              width: double.infinity,
                              child: Text(
                                text!['add_medicine']!,
                                textDirection: lang == 'ur'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                              ),
                            ),
                            content: IntrinsicHeight(
                              child: EditMedicine(
                                  darkMode: darkMode,
                                  text: text,
                                  medicineTime: medicineMap,
                                  medicinetitle: medicinetitle,
                                  medId: medId,
                                  index: index),
                            ),
                          );
                        });
                  },
                ),
                IconButton(
                    onPressed: () {
                      var userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      var medProvider =
                          Provider.of<MedicineProvider>(context, listen: false);
                      UsersRecord()
                          .getUsersData(userProvider.getUid)
                          .then((value) {
                        List<dynamic> medList = value['medicine_list'];
                        List<String> list = [];
                        for (dynamic id in medList) {
                          if (id.toString() != medId) {
                            list.add(id.toString());
                          }
                        }
                        UsersRecord()
                            .updateMedicineList(userProvider.getUid, list);
                        medProvider.removeIndex(index);
                        returnFunction();
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 22,
                      color: darkMode
                          ? AppDarkColors.headingColor
                          : AppColors.headingColor,
                    ))
              ],
            ),
            Text(
              medcinieTimeString,
              style: TextStyle(
                color: darkMode
                    ? AppDarkColors.headingColor
                    : AppColors.headingColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.261,
              ),
            ),
            Text(medicinetitle,
                style: TextStyle(
                  color: darkMode
                      ? AppDarkColors.headingColor
                      : AppColors.headingColor,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.261,
                ))
          ],
        ),
      ),
    );
  }
}
