import 'dart:math';

import 'package:ayyami/providers/medicine_provider.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../firebase_calls/medicine_record.dart';
import 'gradient_button.dart';

class AddMedicine extends StatefulWidget {
  AddMedicine({
    Key? key,
    required this.darkMode,
    required this.text,
  }) : super(key: key);

  bool darkMode;
  Map<String, String> text;

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController medicineTitle = TextEditingController();
  List<String> timingList = [];
  List<Map<String, dynamic>> medTimeList = [];
  String selectedValue = '';
  bool morningSelected = false, eveSelected = false, nightSelected = false;
  late TimeOfDay morningTime, eveTime, nightTime;

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
              controller: medicineTitle,
              decoration: InputDecoration(
                  hintText: widget.text['medicine_name']!, border: InputBorder.none),
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
                    style: TextStyle(
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
                    style: TextStyle(
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
                    style: TextStyle(
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
              String medName = medicineTitle.text;
              DateTime now = DateTime.now();
              bool timingSelect = false;
              var medicineList = userProvider.getMedicinesList;
              Random r = Random();
              print('random number=${50 + r.nextInt(100 - 50)}');

              if (morningSelected) {
                String timeName = 'Morning';
                bool check = false;
                for (var map in medTimeList) {
                  String mapName = map['timeName'];
                  if (timeName == mapName) {
                    check = true;
                    timingSelect = true;
                  }
                }
                if (!check) {
                  var notiID =
                      medTimeList.length + 1000 + r.nextInt(10000 - medicineList.length - 1000);
                  medTimeList.add({
                    'timeName': timeName,
                    'time': Timestamp.fromDate(DateTime(
                        now.year, now.month, now.day, morningTime.hour, morningTime.minute)),
                    'notificationID': notiID
                  });
                  timingSelect = true;
                }
              } else {
                String timeName = 'Morning';
                for (int x = 0; x < medTimeList.length; x++) {
                  String mapName = medTimeList[x]['timeName'];
                  if (timeName == mapName) {
                    medTimeList.removeAt(x);
                    if (!eveSelected && !nightSelected) {
                      timingSelect = false;
                    }
                    break;
                  }
                }
              }

              if (eveSelected) {
                String timeName = 'Evening';
                bool check = false;
                for (var map in medTimeList) {
                  String mapName = map['timeName'];
                  if (timeName == mapName) {
                    check = true;
                    timingSelect = true;
                  }
                }
                if (!check) {
                  var notiID =
                      medTimeList.length + 2000 + r.nextInt(20000 - medicineList.length - 2000);
                  medTimeList.add({
                    'timeName': timeName,
                    'time': Timestamp.fromDate(
                        DateTime(now.year, now.month, now.day, eveTime.hour, eveTime.minute)),
                    'notificationID': notiID
                  });
                  timingSelect = true;
                }
              } else {
                String timeName = 'Evening';
                for (int x = 0; x < medTimeList.length; x++) {
                  String mapName = medTimeList[x]['timeName'];
                  if (timeName == mapName) {
                    medTimeList.removeAt(x);
                    if (!morningSelected && !nightSelected) {
                      timingSelect = false;
                    }
                    break;
                  }
                }
              }

              if (nightSelected) {
                String timeName = 'Night';
                bool check = false;
                for (var map in medTimeList) {
                  String mapName = map['timeName'];
                  if (timeName == mapName) {
                    check = true;
                    timingSelect = true;
                  }
                }
                if (!check) {
                  var notiID =
                      medTimeList.length + 3000 + r.nextInt(30000 - medicineList.length - 3000);
                  medTimeList.add({
                    'timeName': timeName,
                    'time': Timestamp.fromDate(
                        DateTime(now.year, now.month, now.day, nightTime.hour, nightTime.minute)),
                    'notificationID': notiID
                  });
                  timingSelect = true;
                }
              } else {
                String timeName = 'Night';
                for (int x = 0; x < medTimeList.length; x++) {
                  String mapName = medTimeList[x]['timeName'];
                  if (timeName == mapName) {
                    medTimeList.removeAt(x);
                    if (!morningSelected && !eveSelected) {
                      timingSelect = false;
                    }
                    break;
                  }
                }
              }

              if (medName.isNotEmpty && timingSelect) {
                MedicineRecord().uploadMedicine(
                    userProvider.getUid, medTimeList, medName, medicineList, provider, context);
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
