import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/medicine_model.dart';

class AddMedicine extends StatefulWidget {
  AddMedicine({Key? key, required this.darkMode, required this.text}) : super(key: key);

  bool darkMode;
  Map<String, String> text;

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController medicineTitle = TextEditingController();
  List<String> timingList = [];
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PrayerProvider>();
    return Consumer<PrayerProvider>(builder: (context, child, build) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var lang = userProvider.getLanguage;
      if (lang == 'ur') {
        timingList = child.medicineTimingListUrdu;

        child.setMedicineTime('صبح');
      } else {
        timingList = child.medicineTimingList;
        child.setMedicineTime('Morning');
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
          Directionality(
            textDirection: lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
            child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all()),
                padding: const EdgeInsets.only(left: 8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: timingList.map((e) {
                      return DropdownMenuItem(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            e,
                            textDirection: lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                          ),
                        ),
                        value: e,
                      );
                    }).toList(),
                    isExpanded: true,
                    value: child.medicineTimeValue,
                    onChanged: (v) {
                      provider.setMedicineTime(v!);
                    },
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              provider
                  .addToMedicineList(MedicineModel(medicalTile: medicineTitle.text, timing: child.medicineTimeValue));
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: 82.h,
              decoration: BoxDecoration(color: const Color(0xffd9d9d9), borderRadius: BorderRadius.circular(8.r)),
              child: Center(
                  child: Text(
                widget.text['add_medicine']!,
                style: TextStyle(color: widget.darkMode ? AppDarkColors.headingColor : AppDarkColors.headingColor),
              )),
            ),
          )
        ],
      );
    });
  }
}
