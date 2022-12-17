import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/const.dart';
import '../constants/images.dart';
import '../models/medicine_model.dart';
import '../providers/prayer_provider.dart';
import '../widgets/app_text.dart';
import '../widgets/utils.dart';
import 'medicine_reminder.dart';
class AddMedicineReminder extends StatefulWidget {
  const AddMedicineReminder({Key? key}) : super(key: key);

  @override
  State<AddMedicineReminder> createState() => _AddMedicineReminderState();
}

class _AddMedicineReminderState extends State<AddMedicineReminder> {
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final medicineController = TextEditingController();
  bool morningSelected = false;
  bool eveningSelected = false;
  bool nightSelected = false;

  @override
  Widget build(BuildContext context) {
   final provider = context.read<PrayerProvider>();
    return Scaffold(
      body: Container(
        height: getHeight(context),
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 70.w,
              right: 70.w,
              top: 80.h,
            ),
            child: SingleChildScrollView(
                child: Column(children: [
              SizedBox(width: 110.w),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppImages.logo,
                  width: 249.6.w,
                  height: 78.4.h,
                ),
              ),
               const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(
                      AppImages.backIcon,
                      width: 49.w,
                      height: 34.h,
                    ),
                  ),
                  SizedBox(width: 55),
                  const AppText(
                    text: 'Add medicine',
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w700,
                    )
                  ],
              ),
              const SizedBox(height: 120),
              Container(
                alignment: Alignment.centerLeft,
                child: const AppText(
                  text: 'Medicine Name',
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Color(0xff8F92A1),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SvgPicture.asset(
                        AppImages.medicineIcon,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: medicineController,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.headingColor),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add Medicine",
                            hintStyle: TextStyle(color: AppColors.headingColor),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Medincine Name";
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                width: 830.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: const Color(0xFf8F92A1).withOpacity(0.3),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ---- one Row as a Day Start
                  InkWell(
                    onTap: () {
                      setState(() {
                        morningSelected = !morningSelected;
                      });
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: morningSelected
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.headingColor,
                                width: 1.5.w,
                                strokeAlign: StrokeAlign.inside,
                              ),
                              gradient: AppColors.bgPinkishGradient,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x1e1f3d73),
                                    offset: Offset(0, 12),
                                    blurRadius: 40,
                                    spreadRadius: 0)
                              ],
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.headingColor,
                                width: 1.5.w,
                                strokeAlign: StrokeAlign.inside,
                              ),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x1e1f3d73),
                                    offset: Offset(0, 12),
                                    blurRadius: 40,
                                    spreadRadius: 0)
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Morning",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8F92A1),
                    ),
                  ),
                  // ---- one Row as a Day end

                  const SizedBox(width: 10),

                  // ---- one Row as a Day Start
                  InkWell(
                    onTap: () {
                      setState(() {
                        eveningSelected = !eveningSelected;
                      });
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: eveningSelected
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.headingColor,
                                width: 1.5.w,
                                strokeAlign: StrokeAlign.inside,
                              ),
                              gradient: AppColors.bgPinkishGradient,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x1e1f3d73),
                                    offset: Offset(0, 12),
                                    blurRadius: 40,
                                    spreadRadius: 0)
                              ],
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.headingColor,
                                width: 1.5.w,
                                strokeAlign: StrokeAlign.inside,
                              ),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x1e1f3d73),
                                    offset: Offset(0, 12),
                                    blurRadius: 40,
                                    spreadRadius: 0)
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Evening",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8F92A1),
                    ),
                  ),
                  // ---- one Row as a Day end
                  const SizedBox(width: 10),
                  // ---- one Row as a Day Start
                  InkWell(
                    onTap: () {
                      setState(() {
                        nightSelected = !nightSelected;
                      });
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: nightSelected
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.headingColor,
                                width: 1.5.w,
                                strokeAlign: StrokeAlign.inside,
                              ),
                              gradient: AppColors.bgPinkishGradient,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x1e1f3d73),
                                    offset: Offset(0, 12),
                                    blurRadius: 40,
                                    spreadRadius: 0)
                              ],
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.headingColor,
                                width: 1.5.w,
                                strokeAlign: StrokeAlign.inside,
                              ),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x1e1f3d73),
                                    offset: Offset(0, 12),
                                    blurRadius: 40,
                                    spreadRadius: 0)
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Night",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8F92A1),
                    ),
                  ),
                  // ---- one Row as a Day end
                ],
              ),
              const SizedBox(height: 35),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (morningSelected == true &&
                          eveningSelected == true &&
                          nightSelected == true) {
                        toast_notification()
                            .toast_message("Please select only one");
                        return;
                      }

                      if (morningSelected == true && eveningSelected == true) {
                        toast_notification()
                            .toast_message("Please select only one");
                        return;
                      }

                      if (morningSelected == true && nightSelected == true) {
                        toast_notification()
                            .toast_message("Please select only one");
                        return;
                      }

                      if (eveningSelected == true && nightSelected == true) {
                        toast_notification()
                            .toast_message("Please select only one");
                        return;
                      }

                      if (morningSelected == true) {
                        provider.addToMedicineList(MedicineModel(
                            medicalTile: medicineController.text,
                            timing: 'Morning'));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MedicineReminderScreen()));
                      } else if (eveningSelected == true) {
                        provider.addToMedicineList(MedicineModel(
                            medicalTile: medicineController.text,
                            timing: 'Evening'));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MedicineReminderScreen()));
                      } else if (nightSelected == true) {
                        provider.addToMedicineList(MedicineModel(
                            medicalTile: medicineController.text,
                            timing: 'Night'));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MedicineReminderScreen()));
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.purpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(0.0)),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xffFFBBE6), Color(0xffC43CF3)],
                          begin: Alignment.centerLeft,
                          end: Alignment.center),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 360,
                          minHeight: 50,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Add Medicine".toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                  ))
            ])),
          ),
        ),
      ),
    );
  }
}
