import 'package:ayyami/firebase_calls/medicine_record.dart';
import 'package:ayyami/providers/medicine_provider.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../utils/notification.dart';
import 'gradient_button.dart';

class EditMedicine extends StatefulWidget {
  EditMedicine(
      {Key? key,
      required this.darkMode,
      required this.text,
      required this.medicineTime,
      required this.medicinetitle,
      required this.medId,
      required this.index})
      : super(key: key);

  String medicinetitle, medId;
  bool darkMode;
  Map<String, String> text;
  Map<String, dynamic> medicineTime;
  int index;

  @override
  State<EditMedicine> createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
  TextEditingController medicineTitleController = TextEditingController();
  List<String> timingList = [];
  List<Map<String, dynamic>> medTimeList = [];
  String selectedValue = '';
  bool morningSelected = false, eveSelected = false, nightSelected = false;
  late TimeOfDay morningTime, eveTime, nightTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    medicineTitleController = TextEditingController(text: widget.medicinetitle);
    if (widget.medicineTime['timeName'].contains('Morning')) {
      morningSelected = true;
    }
    if (widget.medicineTime['timeName'].contains('Evening')) {
      eveSelected = true;
    }
    if (widget.medicineTime['timeName'].contains('Night')) {
      nightSelected = true;
    }
    setState(() {});
  }

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
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all()),
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              controller: medicineTitleController,
              decoration: InputDecoration(
                  hintText: widget.text['medicine_name']!, border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // StatefulBuilder(builder: (c,state){
          //   return  Directionality(
          //     textDirection: lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
          //     child: Container(
          //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all()),
          //         padding: const EdgeInsets.only(left: 8.0),
          //         child: DropdownButton<String>(underline: Container(),
          //           items: timingList.map((e) {
          //             return DropdownMenuItem(
          //               value: e,
          //               child: SizedBox(
          //                 width: double.infinity,
          //                 child: Text(
          //                   e,
          //                   textDirection: lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
          //                 ),
          //               ),onTap: (){print('$e from ontap');},
          //             );
          //           }).toList(),
          //           isExpanded: true,
          //           value: selectedValue,
          //           onChanged: (v) {
          //             print('$v is selected');
          //             state(() {
          //               selectedValue=v!;
          //             });
          //             print('$selectedValue is selected');
          //             provider.setMedicineTime(v!);
          //             widget.returnFunction;
          //           },
          //
          //         ),),
          //   );
          // }),
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    lang == 'ur' ? 'صبح' : 'Morning',
                    style: const TextStyle(
                        color: AppColors.headingColor, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      gradient: morningSelected
                          ? AppColors.bgPinkishGradient
                          : AppColors.transparentGradient,
                      border: Border.all(width: 1.0, color: AppColors.headingColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onTap: () {
                    var now = TimeOfDay.now();
                    if (!morningSelected) {
                      showTimePicker(
                        context: context,
                        initialTime: now,
                      ).then((value) {
                        print('${value?.hour}--${value?.hourOfPeriod}');
                        print('${value?.minute}--${value?.period.name}');
                        if (value?.hour != null) {
                          morningTime = value!;
                          setState(() {
                            morningSelected = !morningSelected;
                          });
                        }
                      });
                    } else {
                      setState(() {
                        morningSelected = !morningSelected;
                      });
                    }
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
                    style: const TextStyle(
                        color: AppColors.headingColor, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      gradient:
                          eveSelected ? AppColors.bgPinkishGradient : AppColors.transparentGradient,
                      border: Border.all(width: 1.0, color: AppColors.headingColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onTap: () {
                    var now = TimeOfDay.now();
                    if (!eveSelected) {
                      showTimePicker(
                        context: context,
                        initialTime: now,
                      ).then((value) {
                        print('${value?.hour}--${value?.hourOfPeriod}');
                        print('${value?.minute}--${value?.period.name}');
                        if (value?.hour != null) {
                          eveTime = value!;
                          setState(() {
                            eveSelected = !eveSelected;
                          });
                        }
                      });
                    } else {
                      setState(() {
                        eveSelected = !eveSelected;
                      });
                    }
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
                    style: const TextStyle(
                        color: AppColors.headingColor, fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      gradient: nightSelected
                          ? AppColors.bgPinkishGradient
                          : AppColors.transparentGradient,
                      border: Border.all(width: 1.0, color: AppColors.headingColor),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onTap: () {
                    var now = TimeOfDay.now();
                    if (!nightSelected) {
                      showTimePicker(
                        context: context,
                        initialTime: now,
                      ).then((value) {
                        print('${value?.hour}--${value?.hourOfPeriod}');
                        print('${value?.minute}--${value?.period.name}');
                        if (value?.hour != null) {
                          nightTime = value!;
                          setState(() {
                            nightSelected = !nightSelected;
                          });
                        }
                      });
                    } else {
                      setState(() {
                        nightSelected = !nightSelected;
                      });
                    }
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
              String medName = medicineTitleController.text;
              DateTime now = DateTime.now();
              bool timingSelect = false;
              if (morningSelected) {
                medTimeList.add({
                  'timeName': 'Morning',
                  'time': Timestamp.fromDate(
                      DateTime(now.year, now.month, now.day, morningTime.hour, morningTime.minute))
                });
                timingSelect = true;
              }
              if (eveSelected) {
                medTimeList.add({
                  'timeName': 'Evening',
                  'time': Timestamp.fromDate(
                      DateTime(now.year, now.month, now.day, eveTime.hour, eveTime.minute))
                });
                timingSelect = true;
              }
              if (nightSelected) {
                medTimeList.add({
                  'timeName': 'Evening',
                  'time': Timestamp.fromDate(
                      DateTime(now.year, now.month, now.day, nightTime.hour, nightTime.minute))
                });
                timingSelect = true;
              }
              print('$medTimeList');
              if (medName.isNotEmpty && timingSelect) {
                var list = provider.getMap;
                var map = list[widget.index];
                map['timeList'] = medTimeList;
                map['medicine_name'] = medName;
                list[widget.index] = map;
                provider.updateMedMap(list);
                MedicineRecord().editMedicine(widget.medId, medTimeList, medName);
                SendNotification()
                    .medicineEditNotificationTime(widget.index, medTimeList, medName, provider);
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
