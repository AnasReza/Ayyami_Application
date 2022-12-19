import 'package:ayyami/providers/prayer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../models/medicine_model.dart';
class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController medicineTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = context.read<PrayerProvider>();
    return Consumer<PrayerProvider>(
      builder: (context,child,build) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              ),
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                controller: medicineTitle,
                decoration: const InputDecoration(
                    hintText: "Medicine Name",
                    border: InputBorder.none
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                ),
                padding: const EdgeInsets.only(left: 8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: child.medicineTimingList.map((e){
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    isExpanded: true,
                    value: child.medicineTimeValue,
                    onChanged: (v){
                      provider.setMedicineTime(v!);
                    },
                  ),
                )
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (){
                provider.addToMedicineList(MedicineModel(medicalTile: medicineTitle.text, timing: child.medicineTimeValue));
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 82.h,
                decoration: BoxDecoration(
                    color: const Color(0xffd9d9d9),
                    borderRadius: BorderRadius.circular(8.r)),
                child: const Center(
                    child: Text("Add Medicine")
                ),
              ),
            )
          ],
        );
      }
    );
  }
}
