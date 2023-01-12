import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/screens/Questions/where_are_you_from.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../widgets/gradient_button.dart';

class MenstrualPeriodStartDate extends StatefulWidget {
  String uid;

  MenstrualPeriodStartDate({required this.uid, super.key});

  @override
  State<MenstrualPeriodStartDate> createState() => MenstrualPeriodStartDateState();
}

class MenstrualPeriodStartDateState extends State<MenstrualPeriodStartDate> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  DateTime? Startdate;

  TimeOfDay? Starttime;

  String? SelectedStartTime;
  String? SelectedEndTime;
  String? SelectedStartDate;
  String? SelectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 140,
                width: 200,
                child: Image.asset("assets/images/icon_name.png"),
              ),
              SizedBox(height: 5),
              Container(
                height: 130,
                width: 180,
                child: Image.asset("assets/images/question_one_icon.png"),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  const Text(
                    "Last menstrual period start:",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              pickStartDate();
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 60, top: 20),
                                  child: const Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF1F3D73),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 22, left: 10),
                                  child: Text(
                                    getStartDate(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'DMSans',
                                      color: Color(0xff1F3D73),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 58, top: 10),
                                width: 130,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Color(0xFf8F92A1).withOpacity(0.3),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              pickStartTime();
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 60, top: 20),
                                  child: const Icon(
                                    Icons.access_time_outlined,
                                    color: Color(0xFF1F3D73),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 22, left: 10),
                                  child: Text(
                                    getStartTime(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'DMSans',
                                      color: Color(0xff1F3D73),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 58, top: 10),
                                width: 130,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Color(0xFf8F92A1).withOpacity(0.3),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),

              Container(
                child: GradientButton(
                  title: "Confirm",
                  onPressedButon: () {
                    String answer = '$SelectedStartDate@$SelectedStartTime';
                    if (Startdate != null && Starttime != null) {
                      var lastMensesStartDate = DateTime(
                          Startdate!.year, Startdate!.month, Startdate!.day, Starttime!.hour, Startdate!.minute, 0);
                      var startTimeStamp = Timestamp.fromDate(lastMensesStartDate);
                      var provider = Provider.of<MensesProvider>(context, listen: false);
                      QuestionRecord()
                          .uploadMenstrualPeriodQuestionStartDate(widget.uid, startTimeStamp, provider)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationQuestion(
                                      uid: widget.uid,
                                    )));
                      });
                    } else {
                      // add toast for null start date
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MyDialog();
                            });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xff1F3D73),
                        textStyle: const TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: Text("Skip to the tracker"),
                    ),
                  ),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: Color(0xFF1F3D73),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

//Start Date
  Future pickStartDate() async {
    final initialDate = DateTime.now();
    final getstartDate = await showDatePicker(
        context: context,
        initialDate: Startdate ?? initialDate,
        firstDate: DateTime(DateTime.now().month - 5),
        lastDate: DateTime.now());
    if (getstartDate == null) return;

    setState(() {
      Startdate = getstartDate;
    });
  }

  String getStartDate() {
    if (Startdate == null) {
      return 'Select Date';
    } else {
      SelectedStartDate = '${Startdate!.day}-${Startdate!.month}-${Startdate!.year}';
      return '$SelectedStartDate';
    }
  }


  //Start Time
  Future pickStartTime() async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final getStartTime = await showTimePicker(context: context, initialTime: Starttime ?? initialTime);
    if (getStartTime == null) {
      return;
    } else {
      setState(() {
        Starttime = getStartTime;
        SelectedStartTime = Starttime?.format(context);
      });
    }
  }

  String getStartTime() {
    if (Starttime == null) {
      return 'Select Time';
    } else {
      final hours = Starttime?.hour.toString().padLeft(2, '0');
      final minutes = Starttime?.minute.toString().padLeft(2, '0');

      return '$SelectedStartTime';
    }
  }



}
