import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/firebase_calls/medicine_record.dart';
import 'package:ayyami/providers/medicine_provider.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/translation/app_translation.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/medicine_model.dart';
import 'gradient_button.dart';

class AddMedicine extends StatefulWidget {
  AddMedicine({Key? key, required this.darkMode, required this.text,}) : super(key: key);

  bool darkMode;
  Map<String, String> text;


  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController medicineTitle = TextEditingController();
  List<String> timingList = [], medTimeList = [];
  String selectedValue = '';
  bool morningSelected = false, eveSelected = false, nightSelected = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicineProvider>(builder: (context, provider, build) {
      var child = Provider.of<PrayerProvider>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var lang = userProvider.getLanguage;
      if (lang == 'ur') {
        timingList = child.medicineTimingListUrdu;
        child.setMedicineTime('صبح');
        selectedValue = 'صبح';
      } else {
        timingList = child.medicineTimingList;
        child.setMedicineTime('Morning');
        selectedValue = 'Morning';
      }
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all()),
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              controller: medicineTitle,
              decoration: InputDecoration(hintText: widget.text['medicine_name']!, border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    lang == 'ur' ? 'صبح' : 'Morning',
                    style: TextStyle(color: AppColors.headingColor, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      gradient: morningSelected ? AppColors.bgPinkishGradient : AppColors.transparentGradient,
                      border: Border.all(width: 1.0, color: AppColors.headingColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      morningSelected = !morningSelected;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    lang == 'ur' ? 'شام' : 'Evening',
                    style: TextStyle(color: AppColors.headingColor, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      gradient: eveSelected ? AppColors.bgPinkishGradient : AppColors.transparentGradient,
                      border: Border.all(width: 1.0, color: AppColors.headingColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      eveSelected = !eveSelected;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    lang == 'ur' ? 'رات' : 'Night',
                    style: TextStyle(color: AppColors.headingColor, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      gradient: nightSelected ? AppColors.bgPinkishGradient : AppColors.transparentGradient,
                      border: Border.all(width: 1.0, color: AppColors.headingColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      nightSelected = !nightSelected;
                    });
                  },
                ),
              ],
            ),
          ]),

          const SizedBox(
            height: 30,
          ),
          GradientButton(
            title: widget.text['add_medicine']!,
            onPressedButon: () {
              String medName = medicineTitle.text;
              bool timingSelect = false;
              if (morningSelected) {
                medTimeList.add('Morning');
                timingSelect = true;
              }
              if (eveSelected) {
                medTimeList.add('Evening');
                timingSelect = true;
              }
              if (nightSelected) {
                medTimeList.add('Night');
                timingSelect = true;
              }
              if (medName.isNotEmpty && timingSelect) {
                Map<String, dynamic> map = {'timeList': medTimeList, 'medicine_name': medName};
                provider.setMedMap(map);

                var medicineList=userProvider.getMedicinesList;
                MedicineRecord().uploadMedicine(userProvider.getUid,medTimeList,medName,medicineList,provider);

                Navigator.pop(context);
              } else {
                if (medTimeList.isEmpty) {
                  toast_notification().toast_message(widget.text!['enter_med_name']!);
                }
                if (!timingSelect) {
                  toast_notification().toast_message(widget.text!['enter_med_timing']!);
                }
              }
            },
            width: 320,
          ),
        ],
      );
    });
  }
}
