import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../widgets/gradient_button.dart';

class menstrual_period extends StatefulWidget {
  String uid;

  menstrual_period({required this.uid, super.key});

  @override
  State<menstrual_period> createState() => menstrual_periodState();
}

class menstrual_periodState extends State<menstrual_period> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  DateTime? Startdate;
  DateTime? Enddate;
  TimeOfDay? Starttime;
  TimeOfDay? Endtime;
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
              Column(
                children: [
                  const Text("Last menstrual period end:",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'DMSans',
                        color: Color(0xff1F3D73),
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              pickEndDate();
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
                                    getEndDate(),
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
                              pickEndTime();
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
                                    getEndTime(),
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
                    QuestionRecord().uploadMenstrualPeriodQuestion(widget.uid, answer).then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                    });

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
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
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

  //End Date
  Future pickEndDate() async {
    final initialDate = DateTime.now();
    final getendDate = await showDatePicker(
        context: context,
        initialDate: Enddate ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (getendDate == null) return;

    setState(() {
      Enddate = getendDate;
    });
  }

  String getEndDate() {
    if (Enddate == null) {
      return 'Select Date';
    } else {
      SelectedEndDate = '${Enddate!.day}-${Enddate!.month}-${Enddate!.year}';
      return '$SelectedEndDate';
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

  //End Time
  Future pickEndTime() async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final getEndTime = await showTimePicker(context: context, initialTime: Endtime ?? initialTime);
    if (getEndTime == null) {
      return;
    } else {
      setState(() {
        Endtime = getEndTime;
        SelectedEndTime = Endtime?.format(context);
      });
    }
  }

  String getEndTime() {
    if (Endtime == null) {
      return 'Select Time';
    } else {
      final hours = Endtime?.hour.toString().padLeft(2, '0');
      final minutes = Endtime?.minute.toString().padLeft(2, '0');

      return '$SelectedEndTime';
    }
  }
}
